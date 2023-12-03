using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace GymFit.Infrastructure.Configurations
{
    public class PostConfiguration :BaseConfiguration<Post>
    {
        public override void Configure(EntityTypeBuilder<Post> builder)
        {
            base.Configure(builder);

            builder.Property(x=> x.title)
                .IsRequired();

            builder.Property(x => x.content)
                .IsRequired();

            builder.Property(x => x.Status)
              .IsRequired();

            builder.Property(x => x.PublishDate)
              .IsRequired();

         
        }
    }
}
