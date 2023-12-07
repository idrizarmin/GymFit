using GymFit.Application;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Hangfire;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;

namespace GymFit.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, NotificationUpsertDto, NotificationsSearchObject, INotificationsService>
    {
        public NotificationsController(INotificationsService service, ILogger<NotificationsController> logger) : base(service, logger)
        {
        }

        [HttpPost("crateBirthdayNotification")]
        public ActionResult crateBirthdaayNotification() {
            RecurringJob.AddOrUpdate(
            "Run at 00:10 every day//CreateBirthdayNotification",
            () => Service.CreateBirthdayNotifications(),
            "10 0 * * *"
                );

            return Ok();
        }
        [HttpPost("expiringInThreeDays")]
        public ActionResult expiringInThreeDays()
        {
            RecurringJob.AddOrUpdate(
            "Run at 00:15 every day//CreateExpiringUserPackageNotificationsIn3Days",
            () => Service.CreateExpiringBundleNotificationsIn3Days(),
            "15 0 * * *"
                );

            return Ok();
        }
        [HttpPost("expiringToday")]
        public ActionResult expiringToday()
        {
            RecurringJob.AddOrUpdate(
            "Run at 00:20 every day//CreateExpiringUserPackageNotificationsToday",
            () => Service.CreateExpiringBundleNotificationsToday(),
            "20 0 * * *"
                );

            return Ok();
        }
    }
}
