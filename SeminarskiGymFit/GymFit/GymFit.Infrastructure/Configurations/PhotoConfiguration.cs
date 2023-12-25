using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure
{
    public class PhotoConfiguration :BaseConfiguration<Photo>
    {
        public override void Configure(EntityTypeBuilder<Photo> builder)
        {
            base.Configure(builder);

            builder.Property(e => e.Data)
                .IsRequired();

            builder.Property(e => e.ContentType)
                .IsRequired();

            builder.Property(e => e.ThumbnailContent)
             .IsRequired();

            builder.Property(e => e.GuidId)
           .IsRequired();

           

            builder.HasMany(c => c.Users)
              .WithOne(c => c.Photo)
              .HasForeignKey(c => c.PhotoId)
              .IsRequired(false);

           
        }
    }
}
