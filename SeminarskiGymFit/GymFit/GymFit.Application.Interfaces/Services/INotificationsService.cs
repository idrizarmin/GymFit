using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface INotificationsService : IBaseService<int, NotificationDto, NotificationUpsertDto, NotificationsSearchObject>
    {
         Task CreateBirthdayNotifications();
        Task CreateExpiringBundleNotificationsIn3Days();
        Task CreateExpiringBundleNotificationsToday();
    }
}
