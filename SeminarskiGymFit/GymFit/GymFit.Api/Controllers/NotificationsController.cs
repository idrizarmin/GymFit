using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Api.Controllers
{
    public class NotificationsController : BaseCrudController<NotificationDto, NotificationUpsertDto, NotificationsSearchObject, INotificationsService>
    {
        public NotificationsController(INotificationsService service, ILogger<NotificationsController> logger) : base(service, logger)
        {
        }
    }
}
