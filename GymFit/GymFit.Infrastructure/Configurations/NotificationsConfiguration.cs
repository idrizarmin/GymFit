using GymFit.Core;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class NotificationsConfiguration :BaseConfiguration<Notification>
    {
        public override void Configure(EntityTypeBuilder<Notification> builder)
        {
            base.Configure(builder);

            builder.Property(x => x.Content)
                .IsRequired();

            builder.Property(x => x.Read)
                .IsRequired()
                .HasDefaultValue(false);

            builder.Property(x => x.Deleted)
                .IsRequired()
                .HasDefaultValue(false);

            builder.Property(x => x.DateRead)
                .IsRequired(false);

            builder.Property(x => x.SendOnDate)
               .IsRequired(false);

            builder.Property(x => x.Seen)
               .IsRequired(false);

            builder.HasOne(e => e.User)
                 .WithMany(e => e.Notifications)
                 .HasForeignKey(e => e.UserId)
                 .IsRequired();
        }
    }
}
