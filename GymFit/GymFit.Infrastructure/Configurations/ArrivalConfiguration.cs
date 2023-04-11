using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class ArrivalConfiguration : BaseConfiguration<Arrivals>
    {
        public override void Configure(EntityTypeBuilder<Arrivals> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.ArrivalTime)
                  .IsRequired();

            builder.Property(a => a.DepartureTime)
                  .IsRequired(false);

            builder.HasOne(a => a.Reservation)
                .WithMany(r => r.Arrivals)
                .HasForeignKey(a => a.ReservationId)
                .OnDelete(DeleteBehavior.NoAction)
                .IsRequired();

            builder.HasOne(a => a.Gym)
                .WithMany(a=>a.Arrivals)
                .HasForeignKey(a => a.GymId)
                .IsRequired();

            builder.HasOne(a => a.UserPackage)
                .WithMany(a=>a.Arrivals)
                .HasForeignKey(a => a.UserPackageId)
                .OnDelete(DeleteBehavior.NoAction)
                .IsRequired();
            
            builder.HasOne(a => a.User)
                .WithMany(u => u.Arrivals)
                .HasForeignKey(a => a.UserId)
                .OnDelete(DeleteBehavior.NoAction)
                .IsRequired();
        }
    }
}
