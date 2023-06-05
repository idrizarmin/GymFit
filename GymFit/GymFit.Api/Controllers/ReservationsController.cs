using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class ReservationsController : BaseCrudController<ReservationDto, ReservationUpsertDto, BaseSearchObject, IReservationsService>
    {
        public ReservationsController(IReservationsService service, ILogger<ReservationsController> logger) : base(service, logger)
        {
        }
    }
}
