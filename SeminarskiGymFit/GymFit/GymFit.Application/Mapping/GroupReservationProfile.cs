using GymFit.Core;

namespace GymFit.Application
{
    public class GroupReservationProfile : BaseProfile
    {
        public GroupReservationProfile()
        {
            CreateMap<GroupReservationDto, GroupReservations>().ReverseMap();

            CreateMap<GroupReservationUpsertDto, GroupReservations>();
        }
    }
}
