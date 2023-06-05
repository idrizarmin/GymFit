using GymFit.Core;

namespace GymFit.Application
{
    public class GymProfile : BaseProfile
    {
        public GymProfile()
        {
            CreateMap<GymDto, Gym>().ReverseMap();

            CreateMap<GymUpsertDto, Gym>();
        }
    }
}
