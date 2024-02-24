using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class NotificationRabbitRepository : BaseRepository<NotificationRabbit, int, BaseSearchObject>, INotificationRabbitRepository
    {
        public NotificationRabbitRepository(DatabaseContext databaseContext) : base(databaseContext)
        {

        }

        public Task<List<NotificationRabbit>> GetAllByUserId(int id, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.UserId == id).ToListAsync(cancellationToken);
        }

        public async Task<List<NotificationRabbit>> GetAllNotifications(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default)
        {

            var notificaations = await DbSet.Include(s => s.User).Where(n => (searchObject.seen == null || n.IsRead == searchObject.seen)
                  && (searchObject.userId == null || n.UserId == searchObject.userId)
                  && (searchObject.content == null || n.Content.ToLower().Contains(searchObject.content.ToLower()))
                  && (n.IsDeleted == false)).ToListAsync(cancellationToken);

            return notificaations;
        }

        public async Task<PagedList<NotificationRabbit>> GetPagedAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(s => s.User).Where(n => (searchObject.seen == null || n.IsRead == searchObject.seen)
                 && (searchObject.userId == null || n.UserId == searchObject.userId)
                 && (searchObject.content == null || n.Content.ToLower().Contains(searchObject.content.ToLower())))
                 .ToPagedListAsync(searchObject, cancellationToken);
        }
    }
}
