using GymFit.Core;

namespace GymFit.Application
{
    public class PackageProfile : BaseProfile
    {
        public PackageProfile() {

            CreateMap<PackageDto, Package>().ReverseMap();

            CreateMap<PackageUpsertDto, Package>();
        }
      
    }
}
