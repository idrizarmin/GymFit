using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;


namespace GymFit.Infrastructure.Interfaces
{
    public interface INotificationRabbitRepository :IBaseRepository<NotificationRabbit,int,BaseSearchObject>
    {
        Task<List<NotificationRabbit>> GetAllNotifications(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<NotificationRabbit>> GetAllByUserId(int id, CancellationToken cancellationToken = default);
        Task<PagedList<NotificationRabbit>> GetPagedAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default);
    }
}
