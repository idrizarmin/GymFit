using GymFit.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore.Storage;

namespace GymFit.Infrastructure
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly DatabaseContext _databaseContext;

        public readonly IArrivalsRepository ArrivalsRepository;
        public readonly ICertificatesRepository CertificatesRepository;
        public readonly ICitiesRepository CitiesRepository;
        public readonly ICountriesRepository CountriesRepository;
        public readonly IGroupReservationsRepository GroupReservationsRepository;
        public readonly IGymRepository GymRepository;
        public readonly INotificationsRepository NotificationsRepository;
        public readonly IPhotosRepository PhotosRepository;
        public readonly IReservationsRepository ReservationsRepository;
        public readonly ITrainerCertificatesRepository TrainerCertificatesRepository;
        public readonly IUserPackageRepository UserPackageRepository;
        public readonly IUserRepository UserRepository;
        public readonly IClientProgresRepository ClientProgresRepository;
        public readonly IPostRepository PostRepository;
        public readonly IPackageRepository PackageRepository;
        public readonly ITransactionRepository TransactionRepository;


        public UnitOfWork(DatabaseContext databaseContext,
            IArrivalsRepository arrivalsRepository,
            ICertificatesRepository certificatesRepository,
            ICitiesRepository citiesRepository,
            ICountriesRepository countriesRepository,
            IGroupReservationsRepository groupReservationsRepository,
            IGymRepository gymRepository,
            INotificationsRepository notificationsRepository,
            IPhotosRepository photosRepository,
            IReservationsRepository reservationsRepository,
            ITrainerCertificatesRepository trainerCertificatesRepository,
            IUserPackageRepository userPackageRepository,
            IUserRepository userRepository,
            IClientProgresRepository clientProgresRepository,
            IPostRepository postRepository,
            IPackageRepository packageRepository,
            ITransactionRepository transactionRepository)
        {
            _databaseContext = databaseContext;
            ArrivalsRepository = arrivalsRepository;
            CertificatesRepository = certificatesRepository;
            CitiesRepository = citiesRepository;
            CountriesRepository = countriesRepository;
            GroupReservationsRepository = groupReservationsRepository;
            GymRepository = gymRepository;
            NotificationsRepository = notificationsRepository;
            PhotosRepository = photosRepository;
            ReservationsRepository = reservationsRepository;
            TrainerCertificatesRepository = trainerCertificatesRepository;
            UserPackageRepository = userPackageRepository;
            UserRepository = userRepository;
            ClientProgresRepository = clientProgresRepository;
            PostRepository = postRepository;
            PackageRepository = packageRepository;
            TransactionRepository = transactionRepository;
        }

        public async Task<IDbContextTransaction> BeginTransactionAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.Database.BeginTransactionAsync(cancellationToken);
        }

        public async Task CommitTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.CommitTransactionAsync(cancellationToken);
        }

        public async Task RollbackTransactionAsync(CancellationToken cancellationToken = default)
        {
            await _databaseContext.Database.RollbackTransactionAsync(cancellationToken);
        }

        public async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            return await _databaseContext.SaveChangesAsync(cancellationToken);
        }
    }
}
