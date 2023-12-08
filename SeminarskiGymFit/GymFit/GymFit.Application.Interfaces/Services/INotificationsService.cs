﻿using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface INotificationsService : IBaseService<int, NotificationDto, NotificationUpsertDto, NotificationsSearchObject>
    {
        Task<List<NotificationDto>> GetAllNotificationsAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default);

        Task CreateBirthdayNotifications();
        Task CreateExpiringBundleNotificationsIn3Days();
        Task CreateExpiringBundleNotificationsToday();
    }
}
