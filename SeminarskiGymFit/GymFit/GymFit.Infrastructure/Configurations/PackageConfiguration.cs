using GymFit.Core;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Infrastructure.Configurations
{
    public class PackageConfiguration : BaseConfiguration<Package>
    {
        public override void Configure(EntityTypeBuilder<Package> builder)
        {
            base.Configure(builder);

            builder.Property(x=> x.name)
                .IsRequired();

            builder.Property(x => x.description)
                .IsRequired(false);


            builder.Property(x => x.price)
                .IsRequired();


        }
    }
}
