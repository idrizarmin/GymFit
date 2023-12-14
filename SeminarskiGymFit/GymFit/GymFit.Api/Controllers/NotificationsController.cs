using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Hangfire;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, NotificationUpsertDto, NotificationsSearchObject, INotificationsService>
    {
        public NotificationsController(INotificationsService service, ILogger<NotificationsController> logger) : base(service, logger)
        {
        }
        [HttpGet("GetAllNotifications")]
        public async Task<IActionResult> GetAllNotifications([FromQuery] NotificationsSearchObject searchObject, CancellationToken cancellationToken)
        {
            try
            {
                var dto = await Service.GetAllNotificationsAsync(searchObject , cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpPut("SetNotificationsAsSeen")]
        public async Task<IActionResult> SetNotificaationAsSeen(int userId, CancellationToken cancellationToken)
        {
            try
            {
                var message = await Service.SetNotificationsAsSeenAsMessageAsync(userId, cancellationToken);
                return Ok(message);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }
        [HttpPut("SetNotificationAsDeleted")]
        public async Task<IActionResult> SetNotificaationAsDeleted(int id, CancellationToken cancellationToken)
        {
            try
            {
                var message = await Service.SetNotificationAsDeleted(id, cancellationToken);
                return Ok(message);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
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
