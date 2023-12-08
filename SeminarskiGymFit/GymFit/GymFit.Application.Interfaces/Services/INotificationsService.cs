using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface INotificationsService : IBaseService<int, NotificationDto, NotificationUpsertDto, NotificationsSearchObject>
    {
        Task<List<NotificationDto>> GetAllNotificationsAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<Message> SetNotificationAsDeleted(int id, CancellationToken cancellationToken);
        Task<Message> SetNotificationsAsSeenAsMessageAsync(int userId, CancellationToken cancellationToken);

        Task CreateBirthdayNotifications();
        Task CreateExpiringBundleNotificationsIn3Days();
        Task CreateExpiringBundleNotificationsToday();
    }
}
