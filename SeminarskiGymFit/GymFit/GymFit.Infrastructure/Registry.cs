using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Repositories;
using Microsoft.Extensions.DependencyInjection;

namespace GymFit.Infrastructure
{
    public static class Registry
    {
        public static void AddInfrastructure(this IServiceCollection services)
        {
            services.AddScoped<IArrivalsRepository, ArrivalsRepository>();
            services.AddScoped<ICertificatesRepository, CertificatesRepository>();
            services.AddScoped<ICitiesRepository,CitiesRepository>();
            services.AddScoped<ICountriesRepository, CountriesRepository>();
            services.AddScoped<IGroupReservationsRepository, GroupReservationsRepository>();
            services.AddScoped<IGymRepository, GymRepository>();
            services.AddScoped<INotificationsRepository, NotificationsRepository>();
            services.AddScoped<IPhotosRepository, PhotosRepository>();
            services.AddScoped<IReservationsRepository, ReservationsRepository>();
            services.AddScoped<ITrainerCertificatesRepository, TrainerCertificatesRepository>();
            services.AddScoped<IUserPackageRepository, UserPackageRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IClientProgresRepository, ClientProgresRepository>();
            services.AddScoped<IPostRepository,PostsRepository>();
            services.AddScoped<IPackageRepository,PackageRepository>();
            services.AddScoped<ITransactionRepository,TransactionsRepository>();
            services.AddScoped<INotificationRabbitRepository, NotificationRabbitRepository>();

            services.AddScoped<IUnitOfWork, UnitOfWork>();
        }
    }
}
