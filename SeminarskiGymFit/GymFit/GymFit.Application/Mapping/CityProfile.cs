using GymFit.Core;

namespace GymFit.Application
{
    public class CityProfile : BaseProfile
    {
        public CityProfile()
        {
            CreateMap<CityDto, City>().ReverseMap();

            CreateMap<CityUpsertDto, City>();
        }
    }
}
