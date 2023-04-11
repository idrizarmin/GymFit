using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class CityConfiguration :BaseConfiguration<City>
    {
        public override void Configure(EntityTypeBuilder<City> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Name)
                .IsRequired();

            builder.Property(e => e.ZipCode)
                .IsRequired();
            
            builder.Property(e => e.IsActive)
               .IsRequired();

            builder.HasOne(e => e.Country)
                .WithMany(e => e.Cities)
                .HasForeignKey(e => e.CountryId)
                .IsRequired();

            builder.HasMany(c => c.Gyms)
               .WithOne(c => c.City)
               .HasForeignKey(c => c.CityId)
               .IsRequired();
           
            builder.HasMany(c => c.Users)
               .WithOne(c => c.City)
               .HasForeignKey(c => c.CityId)
               .IsRequired();
        }
    }
}
