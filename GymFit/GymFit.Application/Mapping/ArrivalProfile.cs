using GymFit.Core;

namespace GymFit.Application
{
    public class ArrivalProfile : BaseProfile
    {
        public ArrivalProfile()
        {
            CreateMap<ArrivalDto, Arrivals>().ReverseMap();

            CreateMap<ArrivalUpsertDto, Arrivals>();
        }
    }
}
