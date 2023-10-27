using GymFit.Core;

namespace GymFit.Application
{
    public class ReservationProfile : BaseProfile
    {
        public ReservationProfile()
        {
            CreateMap<ReservationDto, Reservation>().ReverseMap();

            CreateMap<ReservationUpsertDto, Reservation>();
        }
    }
}
