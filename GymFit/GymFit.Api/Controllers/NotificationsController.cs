using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, NotificationUpsertDto, BaseSearchObject, INotificationsService>
    {
        public NotificationsController(INotificationsService service, ILogger<NotificationsController> logger) : base(service, logger)
        {
        }
    }
}
