using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class GroupReservationController : BaseCrudController<GroupReservationDto, GroupReservationUpsertDto, BaseSearchObject, IGroupReservationsService>
    {
        public GroupReservationController(IGroupReservationsService service, ILogger<GroupReservationController> logger) : base(service, logger)
        {
        }
    }
}
