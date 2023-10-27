using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class GymConfiguration:BaseConfiguration<Gym>
    {
        public override void Configure(EntityTypeBuilder<Gym> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Name)
                .IsRequired();

            builder.Property(x => x.Address)
                .IsRequired();

            builder.Property(x => x.Description)
                .IsRequired();

            builder.Property(x => x.PhoneNumber)
                .IsRequired();

            builder.Property(x => x.Website)
                .IsRequired(false);

            builder.HasOne(e => e.City)
              .WithMany(e => e.Gyms)
              .HasForeignKey(e => e.CityId)
              .IsRequired();

            builder.HasOne(e => e.Photo)
            .WithMany(e => e.Gyms)
            .HasForeignKey(e => e.PhotoId)
            .IsRequired();

            builder.HasMany(c => c.Arrivals)
               .WithOne(c => c.Gym)
               .HasForeignKey(c => c.GymId)
               .IsRequired();

            builder.HasMany(c => c.Reservations)
              .WithOne(c => c.Gym)
              .HasForeignKey(c => c.GymId)
              .IsRequired();
        }
    }
}
