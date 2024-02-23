using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class NotificationRabbitController : BaseCrudController<NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject, INotificationRabbitService>
    {
        public NotificationRabbitController(INotificationRabbitService service, ILogger<NotificationRabbitController> logger) : base(service, logger)
        {
        }
    }
}
