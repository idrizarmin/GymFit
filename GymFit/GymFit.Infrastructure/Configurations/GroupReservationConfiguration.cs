using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class GroupReservationConfiguration : BaseConfiguration<GroupReservations>
    {
        public override void Configure(EntityTypeBuilder<GroupReservations> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.ConfirmationDate)
                    .IsRequired();

            builder.Property(e => e.Arrived)
                  .IsRequired();

            builder.HasOne(e => e.Reservation)
                .WithMany(e => e.GroupReservations)
                .HasForeignKey(e => e.ReservationId)
                .IsRequired();

            builder.HasOne(e => e.User)
               .WithMany(e => e.GroupReservations)
               .HasForeignKey(e => e.UserId)
               .OnDelete(DeleteBehavior.NoAction)
               .IsRequired();
        }
    }
}
