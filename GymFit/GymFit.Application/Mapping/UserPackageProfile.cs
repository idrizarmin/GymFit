using GymFit.Core;

namespace GymFit.Application
{
    public class UserPackageProfile : BaseProfile
    {
        public UserPackageProfile()
        {
            CreateMap<UserPackageDto, UserPackage>().ReverseMap();

            CreateMap<UserPackageUpsertDto, UserPackage>();
        }
    }
}
