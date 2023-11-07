using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface INotificationsRepository : IBaseRepository<Notification, int, NotificationsSearchObject>
    {
    }
}
