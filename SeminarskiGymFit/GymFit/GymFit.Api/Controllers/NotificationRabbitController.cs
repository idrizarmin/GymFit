using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class NotificationRabbitController : BaseCrudController<NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject, INotificationRabbitService>
    {
        public NotificationRabbitController(INotificationRabbitService service, ILogger<NotificationRabbitController> logger) : base(service, logger)
        {
        }

        [HttpPut("SetNotificationsAsSeen")]
        public async Task<IActionResult> SetNotificaationAsSeen(int id, CancellationToken cancellationToken)
        {
            try
            {
                var message = await Service.SetNotificationsAsSeenAsMessageAsync(id, cancellationToken);
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
    }
}
