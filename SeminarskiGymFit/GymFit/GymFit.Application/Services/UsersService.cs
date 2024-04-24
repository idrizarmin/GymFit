using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Common.Services;
using GymFit.Core;
using GymFit.Core.Dtos.User;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace GymFit.Application
{
    public class UsersService : BaseService<User, UserDto, UserUpsertDto, UserSearchObject, IUserRepository>, IUserService
    {
        private readonly ICryptoService _cryptoService;
        private readonly IPhotosService _photosService;
        private readonly DatabaseContext _db;

        public UsersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserUpsertDto> validator, ICryptoService cryptoService, IPhotosService photosService, DatabaseContext db) : base(mapper, unitOfWork, validator)
        {
            _cryptoService = cryptoService;
            _photosService = photosService;
            _db = db;
        }

        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;


        public async Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByEmailAsync(email, cancellationToken);
            return Mapper.Map<UserSensitiveDto>(user);
        }
        public async Task<int> getCountOfUsersAsync(CancellationToken cancellationToken)
        {

          return  CurrentRepository.getCountOfUsersAsync(cancellationToken);
        }
        public async Task<int> getCountOfUsersActiveAsync(CancellationToken cancellationToken)
        {

            return CurrentRepository.getCountOfUsersActiveAsync(cancellationToken);
        }
        public async Task<int> getCountOfUsersInactiveAsync(CancellationToken cancellationToken)
        {

            return   CurrentRepository.getCountOfUsersInactiveAsync(cancellationToken);
        }

        public async Task<List<UserForSelectionDto?>> GetUserForSelectionAsync( CancellationToken cancellationToken = default){
            var users = await CurrentRepository.GetUsersForSelection(cancellationToken);

            return Mapper.Map<List<UserForSelectionDto?>>(users);
        }
        public async Task<List<UserForSelectionDto?>> GetTrainersForSelectionAsync(CancellationToken cancellationToken = default)
        {
            var users = await CurrentRepository.GetTrainersForSelection(cancellationToken);

            return Mapper.Map<List<UserForSelectionDto?>>(users);
        }
        public async Task<List<UserDto?>> GetAllTrainersAsync(CancellationToken cancellationToken = default)
        {
            var users = await CurrentRepository.GetAllTrainers(cancellationToken);

            return Mapper.Map<List<UserDto?>>(users);
        }
        public async Task<PagedList<UserDto>> GetAdminsPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var users = await CurrentRepository.GetAdminsPagedAsync(searchObject, cancellationToken);

            return Mapper.Map<PagedList<UserDto>>(users);
        }
        public async Task<PagedList<UserDto>> GetTrainersPagedAsync(UserSearchObject searchObject,CancellationToken cancellationToken = default)
        {
            var users = await CurrentRepository.GetTrainersPagedAsync(searchObject, cancellationToken);

            return Mapper.Map<PagedList<UserDto>>(users);


        }

        public override async Task<UserDto> AddAsync(UserUpsertDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            var entity = Mapper.Map<User>(dto);

            entity.PasswordSalt = _cryptoService.GenerateSalt();
            entity.PasswordHash = _cryptoService.GenerateHash(dto.Password!, entity.PasswordSalt);

            //if (dto.profilePhoto != null)
                
            //    entity.Photo = Mapper.Map<Photo>(dto.profilePhoto);

            await CurrentRepository.AddAsync(entity, cancellationToken);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
            return Mapper.Map<UserDto>(entity);
        }

        public override async Task<UserDto> UpdateAsync(UserUpsertDto dto, CancellationToken cancellationToken = default)
        {
            var user = await CurrentRepository.GetByIdAsync(dto.Id.Value, cancellationToken);
            if (user == null)
                throw new UserNotFoundException();

            Mapper.Map(dto, user);

            if (!string.IsNullOrEmpty(dto.Password))
            {
                user.PasswordSalt = _cryptoService.GenerateSalt();
                user.PasswordHash = _cryptoService.GenerateHash(dto.Password, user.PasswordSalt);
            }

            //if (dto.profilePhoto != null)
            //    user.Photo = Mapper.Map<Photo>(dto.profilePhoto);

            CurrentRepository.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);

            return Mapper.Map<UserDto>(user);
        }

        public async Task ChangePassword(UserChangePasswordDto dto, CancellationToken cancellationToken)
        {
            var user = await CurrentRepository.GetByIdAsync(dto.Id, cancellationToken);

            if (user == null)
                throw new UserNotFoundException();

            if (!_cryptoService.Verify(user.PasswordHash, user.PasswordSalt, dto.Password))
                throw new UserWrongCredentialsException();

            user.PasswordSalt = _cryptoService.GenerateSalt();
            user.PasswordHash = _cryptoService.GenerateHash(dto.NewPassword, user.PasswordSalt);

            CurrentRepository.Update(user);
            await UnitOfWork.SaveChangesAsync(cancellationToken);
        }


        public List<UserDto> Recommend(int userId)
        {
            var userReservations = _db.Reservations
                .Include(r => r.Trainer)
                .Where(r => r.UserId == userId && r.Trainer != null && !string.IsNullOrEmpty(r.Description))
                .ToList();

            var data = userReservations.Select(r => new ReservationEntry
            {
                UserId = (uint)r.UserId,
                TrainerId = (uint)r.TrainerId,
                WorkoutDescription = r.Description
            }).ToList();

            if (mlContext == null)
            {
                mlContext = new MLContext();

                var trainData = mlContext.Data.LoadFromEnumerable(data);

                var options = new MatrixFactorizationTrainer.Options
                {
                    MatrixColumnIndexColumnName = nameof(ReservationEntry.UserId),
                    MatrixRowIndexColumnName = nameof(ReservationEntry.TrainerId),
                    LabelColumnName = "Label",
                    LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                    Alpha = 0.01,
                    Lambda = 0.025,
                    NumberOfIterations = 100,
                    C = 0.00001
                };

                var trainer = mlContext.Recommendation().Trainers.MatrixFactorization(options);
                model = trainer.Fit(trainData);
            }

            var predictions = model.Transform(mlContext.Data.LoadFromEnumerable(data));

            var userIds = data.Select(d => d.UserId).Distinct().ToArray();
            var recommendedTrainers = new List<User>();

            foreach (var userIdToRecommend in userIds)
            {
                var userPredictions = mlContext.Data.CreateEnumerable<UserPrediction>(predictions, reuseRowObject: false)
                    .Where(x => x.UserId == userIdToRecommend)
                    .OrderByDescending(x => x.Score)
                    .FirstOrDefault();

                if (userPredictions != null)
                {
                    var recommendedTrainer = _db.Users.Find(userPredictions.TrainerId);
                    if (recommendedTrainer != null)
                        recommendedTrainers.Add(recommendedTrainer);
                }
            }

            var mostCommonDescription = userReservations
                .GroupBy(r => r.Description)
                .OrderByDescending(g => g.Count())
                .Select(g => g.Key)
                .FirstOrDefault();

            var filteredTrainers = recommendedTrainers
                .Where(t => t.Role == Role.Trener && t.TrainerReservations.Any(r => r.Description == mostCommonDescription))
                .ToList();

            // If no trainers are recommended, find a trainer with the most trainings matching the user's preferences
            if (filteredTrainers.Count == 0)
            {
                var mostFrequentTrainer = userReservations
                    .GroupBy(r => r.TrainerId)
                    .OrderByDescending(g => g.Count())
                    .FirstOrDefault()?
                    .Key;

                if (mostFrequentTrainer.HasValue)
                {
                    var trainerWithMostTrainings = _db.Users.FirstOrDefault(u => u.Id == mostFrequentTrainer && u.Role == Role.Trener);
                    if (trainerWithMostTrainings != null)
                    {
                        return new List<UserDto> { Mapper.Map<UserDto>(trainerWithMostTrainings) };
                    }
                }
            }

            return Mapper.Map<List<UserDto>>(filteredTrainers);
        }

        public class ReservationEntry
        {
            [KeyType(count: 10)]
            public uint UserId { get; set; }

            [KeyType(count: 10)]
            public uint TrainerId { get; set; }

            public string WorkoutDescription { get; set; }

            public float Label { get; set; }
        }
        public class UserPrediction
        {
            [KeyType(count: 10)]
            public uint UserId { get; set; }

            [KeyType(count: 10)]
            public uint TrainerId { get; set; }

            public float Score { get; set; }
        }
    }
}




