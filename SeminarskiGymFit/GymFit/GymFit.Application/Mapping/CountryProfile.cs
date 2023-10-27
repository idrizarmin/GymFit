using GymFit.Core;

namespace GymFit.Application
{
    public class CountryProfile : BaseProfile
    {
        public CountryProfile()
        {
            CreateMap<CountryDto, Country>().ReverseMap();

            CreateMap<CountryUpsertDto, Country>();
        }
    }
}
