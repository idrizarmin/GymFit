using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class ReservationsController : BaseCrudController<ReservationDto, ReservationUpsertDto, ReservationSearchObject, IReservationsService>
    {
        public ReservationsController(IReservationsService service, ILogger<ReservationsController> logger) : base(service, logger)
        {
        }
        [HttpGet("GetAllFiltered")]
        public async Task<IActionResult> GetAllFilteredAsync([FromQuery] ReservationSearchObject reservationSearchObject , CancellationToken cancellationToken)
        {
            try
            {
                var dto = await Service.GetAllFilteredAsync(reservationSearchObject, cancellationToken);
                return Ok(dto);
            }
            catch (Exception e)
            {

                Logger.LogError(e, "Problem with getting resources");
                      return BadRequest();
            }
        }
    }
}
