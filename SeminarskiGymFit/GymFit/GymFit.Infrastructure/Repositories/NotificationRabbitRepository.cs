using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class NotificationRabbitRepository : BaseRepository<NotificationRabbit, int, BaseSearchObject>, INotificationRabbitRepository
    {
        public NotificationRabbitRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
