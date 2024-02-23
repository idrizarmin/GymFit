using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using Microsoft.Extensions.DependencyInjection;

namespace GymFit.Application
{
    public static class Registry
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<ICitiesService, CitiesService>();
            services.AddScoped<IArrivalsService,ArrivalService>();
            services.AddScoped<ICertificatesService, CertificatesService>();
            services.AddScoped<ICountriesService, CountriesService>();
            services.AddScoped<IClientProgresService, ClientProgresService>();
            services.AddScoped<IGroupReservationsService, GroupReservationsService>();
            services.AddScoped<IGymsService, GymsService>();
            services.AddScoped<INotificationsService, NotificationsService>();
            services.AddScoped<IPhotosService, PhotosService>();
            services.AddScoped<IReservationsService, ReservationsService>();
            services.AddScoped<ITrainerCertificatesService, TrainerCertificatesService>();
            services.AddScoped<IUserService, UsersService>();
            services.AddScoped<IUserPackagesService, UserPackagesService>();
            services.AddScoped<IPostService, PostService>();
            services.AddScoped<IPackageService, PackageService>();
            services.AddScoped<ITransactionsService, TransactionsService>();
            services.AddScoped<INotificationRabbitService, NotificationRabbitService>();
        }

        public static void AddValidators(this IServiceCollection services)
        {
            services.AddScoped<IValidator<CityUpsertDto>, CityValidator>();
            services.AddScoped<IValidator<ArrivalUpsertDto>, ArrivalValidator>();
            services.AddScoped<IValidator<CertificateUpsertDto>, CertificateValidator>();
            services.AddScoped<IValidator<CountryUpsertDto>, CountryValidator>();
            services.AddScoped<IValidator<ClientProgresUpsertDto>, ClientProgresValidator>();
            services.AddScoped<IValidator<GroupReservationUpsertDto>, GroupReservationValidator>();
            services.AddScoped<IValidator<GymUpsertDto>, GymValidator>();
            services.AddScoped<IValidator<NotificationUpsertDto>, NotificationValidator>();
            services.AddScoped<IValidator<PhotoUpsertDto>, PhotoValidator>();
            services.AddScoped<IValidator<ReservationUpsertDto>, ReservationValidator>();
            services.AddScoped<IValidator<TrainerCertificateUpsertDto>, TrainerCertificateValidator>();
            services.AddScoped<IValidator<UserUpsertDto>, UserVaidator>();
            services.AddScoped<IValidator<UserPackageUpsertDto>, UserPackageValidator>();
            services.AddScoped<IValidator<PostUpsertDto>, PostValidator>();
            services.AddScoped<IValidator<PackageUpsertDto>, PackageValidator>();
            services.AddScoped<IValidator<TransactionUpsertDto>, TransactionValidator>();
            services.AddScoped<IValidator<NotificationRabbitUpsertDto>, NotificationRabbitValidator>();
        }
    }
}
