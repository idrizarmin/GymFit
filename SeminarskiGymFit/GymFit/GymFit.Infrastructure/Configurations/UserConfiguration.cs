using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class UserConfiguration :BaseConfiguration<User>
    {
        public override void Configure(EntityTypeBuilder<User> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.FirstName)
                .IsRequired();

            builder.Property(x => x.LastName)
                .IsRequired();

            builder.Property(x => x.PhoneNumber)
                .IsRequired();


            builder.Property(x => x.ProfessionalTitle)
                .IsRequired(false);

            builder.Property(e => e.IsVerified)
                .HasDefaultValue(true);

            builder.Property(e => e.IsActive)
               .HasDefaultValue(true);

            builder.Property(e => e.Gender)
                .IsRequired();

            builder.Property(e => e.Role)
                .IsRequired();

            builder.Property(e => e.DateOfBirth)
                .IsRequired();

            builder.Property(e => e.Email)
                .IsRequired();

            builder.Property(e => e.PasswordHash)
                  .IsRequired();

            builder.Property(e => e.PasswordSalt)
                   .IsRequired();


            builder.HasOne(e => e.Photo)
                 .WithMany(e => e.Users)
                 .HasForeignKey(e => e.PhotoId)
                 .IsRequired(false);

            builder.HasMany(e => e.TrainerReservations)
                .WithOne(e => e.Trainer)
                .HasForeignKey(r => r.TrainerId)
                .IsRequired();

            builder.HasMany(e => e.UserReservations)
                .WithOne(e => e.User)
                .HasForeignKey(r => r.UserId)
                .IsRequired();
            
            builder.HasMany(u => u.Arrivals)
                .WithOne(arrival => arrival.User)
                .HasForeignKey(arrival => arrival.UserId)
                .IsRequired();

            builder.HasMany(u => u.TrainerCertificates)
                .WithOne(tc => tc.Trainer)
                .HasForeignKey(tc => tc.TrainerId)
                .IsRequired();

            builder.HasMany(u => u.Notifications)
                .WithOne(n => n.User)
                .HasForeignKey(n => n.UserId)
                .IsRequired();

            builder.HasMany(u => u.UserPackages)
                .WithOne(u => u.User)
                .HasForeignKey(u => u.UserId)
                .IsRequired();

            builder.HasMany(u => u.GroupReservations)
                .WithOne(gr => gr.User)
                .HasForeignKey(gr => gr.UserId)
                .IsRequired();

            builder.HasMany(u => u.ClientProgress)
                .WithOne(cp => cp.User)
                .HasForeignKey(cp => cp.UserId)
                .IsRequired();
        }
    }
}
