using GymFit.Core;

namespace GymFit.Application
{ 
    public class NotificationProfile : BaseProfile
    {
        public NotificationProfile()
        {
            CreateMap<NotificationDto, Notification>().ReverseMap();

            CreateMap<NotificationUpsertDto, Notification>();
        }
    }
}
