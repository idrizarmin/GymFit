using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface INotificationsService : IBaseService<int, NotificationDto, NotificationUpsertDto, BaseSearchObject>
    {
    }
}
