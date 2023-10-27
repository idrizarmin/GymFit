using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class UserPackageConfiguration :BaseConfiguration<UserPackage>
    {
        public override void Configure(EntityTypeBuilder<UserPackage> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.PauseDuration)
               .IsRequired(false);

            builder.Property(x => x.IsPaused)
             .IsRequired();

            builder.Property(x => x.Expired)
            .IsRequired();

            builder.Property(x => x.ActivateOnDate)
               .IsRequired(false);

            builder.Property(x => x.ExpirationDate)
               .IsRequired(false);

            builder.Property(x => x.PausedOnDate)
               .IsRequired(false);

            builder.Property(x => x.ActivateOnDate)
               .IsRequired(false);

            builder.HasOne(e => e.User)
                 .WithMany(e => e.UserPackages)
                 .HasForeignKey(e => e.UserId)
                 .IsRequired();

            builder.HasMany(e => e.Arrivals)
                    .WithOne(e => e.UserPackage)
                    .HasForeignKey(e => e.UserPackageId)
                    .IsRequired();
        }
    }
}
