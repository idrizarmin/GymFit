﻿using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;
using System.Net.WebSockets;

namespace GymFit.Infrastructure
{
    public class NotificationsRepository : BaseRepository<Notification, int, NotificationsSearchObject>, INotificationsRepository
    {
        public NotificationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {

        }

        public override async Task<PagedList<Notification>> GetPagedAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default)
        {

            return await DbSet.Include(s => s.User)
                .Where(d => (searchObject.seen == null || d.Read == searchObject.seen)
                && (searchObject.userId == null || d.UserId == searchObject.userId)
                && (searchObject.content == null || d.Content.ToLower().Contains(searchObject.content.ToLower())))
                .ToPagedListAsync(searchObject, cancellationToken);

        }

    }
}
