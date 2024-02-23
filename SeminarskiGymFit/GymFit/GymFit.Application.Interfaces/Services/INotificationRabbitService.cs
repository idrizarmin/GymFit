using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface INotificationRabbitService : IBaseService<int, NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject>
    {

    }
}
