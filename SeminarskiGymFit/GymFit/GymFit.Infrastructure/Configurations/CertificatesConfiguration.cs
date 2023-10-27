using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class CertificatesConfiguration : BaseConfiguration<Certificates>
    {
        public override void Configure(EntityTypeBuilder<Certificates> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Title)
                .IsRequired();

            builder.Property(e=>e.Issuer)
                .IsRequired();
            
            builder.HasMany(c => c.TrainerCertificates)
                .WithOne(tc => tc.Certificate)
                .HasForeignKey(tc => tc.CertificateId)
                .IsRequired();
        }
    }
}
