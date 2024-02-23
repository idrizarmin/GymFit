using GymFit.Core;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public partial class DatabaseContext : DbContext
    {
        public DbSet<Arrivals> Arrivals { get; set; } = null!;
        public DbSet<Certificates> Certificates { get; set; } = null!;
        public DbSet<City> Citys { get; set; } = null!;
        public DbSet<Country> Countries { get; set; } = null!;
        public DbSet<GroupReservations> GroupReservations { get; set; } = null!;
        public DbSet<Notification> Notifications { get; set; } = null!;
        public DbSet<NotificationRabbit> NotificationsRabbit { get; set; } = null!;
        public DbSet<Gym> Gyms { get; set; } = null!;
        public DbSet<Photo> Photos { get; set; } = null!;
        public DbSet<Reservation> Reservations { get; set; } = null!;
        public DbSet<TrainerCertificate> TrainerCertificates { get; set; } = null!;
        public DbSet<User> Users { get; set; } = null!;
        public DbSet<UserPackage> UserPackages { get; set; } = null!;
        public DbSet<ClientProgress> ClientProgress { get; set; } = null!;
        public DbSet<Post> Post { get; set; } = null!;
        public DbSet<Transactions> Traansactions { get; set; } = null!;
        public DbSet<Package> Package { get; set; } = null!;

        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            SeedData(modelBuilder);
            ApplyConfigurations(modelBuilder);
        }
    }
}
