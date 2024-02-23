using GymFit.Core;
namespace GymFit.Application
{
    public class NotificationRabbitProfile : BaseProfile
    {
        public NotificationRabbitProfile()
        {
            CreateMap<NotificationRabbitDto, NotificationRabbit>().ReverseMap();

            CreateMap<NotificationRabbitUpsertDto, NotificationRabbit>().ReverseMap();
        }
    }
}
