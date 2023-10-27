using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class CountryConfiguration : BaseConfiguration<Country>
    {
        public override void Configure(EntityTypeBuilder<Country> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Name)
                .IsRequired();

            builder.Property(e=>e.Abbreviation)
                .IsRequired();

            builder.Property(e=>e.IsActive)
                .IsRequired();

            builder.HasMany(c => c.Cities)
                .WithOne(city => city.Country)
                .HasForeignKey(city => city.CountryId)
                .IsRequired();
        }
    }
}
