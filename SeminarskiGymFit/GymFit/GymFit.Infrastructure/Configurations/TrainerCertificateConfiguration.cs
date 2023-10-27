using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class TrainerCertificateConfiguration : BaseConfiguration<TrainerCertificate>
    {
        public override void Configure(EntityTypeBuilder<TrainerCertificate> builder)
        {
            base.Configure(builder);


            builder.Property(x => x.Title)
                .IsRequired();

            builder.Property(x => x.DateOfAchievement)
                .IsRequired();

            builder.Property(x => x.Issuer)
                .IsRequired();

            builder.HasOne(e => e.Trainer)
                .WithMany(e => e.TrainerCertificates)
                .HasForeignKey(e => e.TrainerId)
                .IsRequired();

            builder.HasOne(e => e.Certificate)
                .WithMany(e => e.TrainerCertificates)
                .HasForeignKey(e => e.CertificateId)
                .IsRequired();
        }
    }
}
