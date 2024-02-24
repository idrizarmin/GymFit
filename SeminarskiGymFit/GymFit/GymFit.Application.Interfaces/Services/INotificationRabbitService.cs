using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface INotificationRabbitService : IBaseService<int, NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject>
    {
        Task<Message> SetNotificationAsDeleted(int id, CancellationToken cancellationToken);
        Task<Message> SetNotificationsAsSeenAsMessageAsync(int userId, CancellationToken cancellationToken);
    }
}
