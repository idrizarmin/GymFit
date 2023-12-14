using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class TrnsactionConfiguration : BaseConfiguration<Transactions>
    {
        public override void Configure(EntityTypeBuilder<Transactions> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.PayPalTransactionId)
               .IsRequired();

            builder.Property(x => x.Amount)
               .IsRequired();

            builder.Property(x => x.Status)
               .IsRequired();

            builder.Property(x => x.TransactionDate)
               .IsRequired();

            builder.HasOne(t => t.UserPackage)
              .WithMany(up => up.Transactions)
              .HasForeignKey(t => t.userPackageId)
              .OnDelete(DeleteBehavior.Restrict);

        }
    }
}
