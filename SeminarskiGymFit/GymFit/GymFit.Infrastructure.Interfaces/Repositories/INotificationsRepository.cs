using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface INotificationsRepository : IBaseRepository<Notification, int, NotificationsSearchObject>
    {
        Task<List<Notification>> GetAllNotifications(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<Notification>> GetAllByUserId(int id, CancellationToken cancellationToken = default);
    }
}
