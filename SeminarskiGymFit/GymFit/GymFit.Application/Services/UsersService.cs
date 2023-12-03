using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Common.Services;
using GymFit.Core;
using GymFit.Core.Dtos.User;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application
{
    public class UsersService : BaseService<User, UserDto, UserUpsertDto, UserSearchObject, IUserRepository>, IUserService
    {
        private readonly ICryptoService _cryptoService;

        public UsersService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserUpsertDto> validator, ICryptoService cryptoService) : base(mapper, unitOfWork, validator)
        {
            _cryptoService = cryptoService;
        }
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

            if (dto.profilePhoto != null)
                entity.Photo = Mapper.Map<Photo>(dto.profilePhoto);

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

            if (dto.profilePhoto != null)
                user.Photo = Mapper.Map<Photo>(dto.profilePhoto);

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
    }

}
