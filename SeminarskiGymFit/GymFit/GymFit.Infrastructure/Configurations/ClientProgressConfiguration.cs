using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class ClientProgressConfiguration : BaseConfiguration<ClientProgress>
    {
        public override void Configure(EntityTypeBuilder<ClientProgress> builder)
        {
            base.Configure(builder);

            builder.Property(cp => cp.Height);

            builder.Property(cp => cp.Weight);

            builder.Property(cp => cp.Shoulders);

            builder.Property(cp => cp.Arms);

            builder.Property(cp => cp.Chest);

            builder.Property(cp => cp.Stomach);

            builder.Property(cp => cp.Waist);

            builder.Property(cp => cp.Hips);

            builder.Property(cp => cp.Quadriceps);

            builder.Property(cp => cp.Calf);

            builder.Property(cp => cp.BMI);

            builder.Property(cp => cp.UserId)
                .IsRequired();

             builder.HasOne(e => e.User)
                .WithMany(e => e.ClientProgress)
                .HasForeignKey(e => e.UserId)
                .IsRequired();
        }

    }
}
