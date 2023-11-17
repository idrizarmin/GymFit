using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class ReservationConfiguration :BaseConfiguration<Reservation>
    {
        public override void Configure(EntityTypeBuilder<Reservation> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Description)
                .IsRequired();

            builder.Property(x => x.StartDate)
                .IsRequired();

            builder.Property(x => x.EndDate)
                .IsRequired();

            builder.Property(x => x.ReservationDate)
                .IsRequired();

            builder.Property(x => x.Duration)
                .IsRequired(false);

            builder.Property(x => x.PauseDuration)
                .IsRequired(false);

            builder.Property(x => x.MaxCapacity)
                .IsRequired(false);

            builder.Property(x => x.isUsed)
                .IsRequired(false);
            builder.Property(x => x.Status)
                .IsRequired();

            builder.HasOne(e => e.Gym)
               .WithMany(e => e.Reservations)
               .HasForeignKey(e => e.GymId)
               .IsRequired();

            builder.HasOne(e => e.Trainer)
              .WithMany(e => e.TrainerReservations)
              .HasForeignKey(e => e.TrainerId)
              .OnDelete(DeleteBehavior.NoAction)
              .IsRequired(false);

            builder.HasOne(e => e.User)
             .WithMany(e => e.UserReservations)
             .HasForeignKey(e => e.UserId)
             .OnDelete(DeleteBehavior.NoAction)
             .IsRequired();

            builder.HasMany(r => r.Arrivals)
                .WithOne(a => a.Reservation)
                .HasForeignKey(a => a.ReservationId)
                .IsRequired();

            builder.HasMany(r => r.GroupReservations)
                .WithOne(gr => gr.Reservation)
                .HasForeignKey(gr => gr.ReservationId)
                .IsRequired();
        }
    }
}
