﻿using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class ReservationsController : BaseCrudController<ReservationDto, ReservationUpsertDto, ReservationSearchObject, IReservationsService>
    {
        public ReservationsController(IReservationsService service, ILogger<ReservationsController> logger) : base(service, logger)
        {
        }

        [Authorize]
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

        [Authorize]
        [HttpGet("GetByMonth")] 
        public async Task<IActionResult> GetReservationsByMonth([FromQuery] BarChartSearchObject searchObject, CancellationToken cancellationToken)
        {
            try
            {
                var result = await Service.GetCountByMonthAsync(searchObject, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }

        [Authorize]
        [HttpGet("GetCountCurrentMonth")]
        public async Task<IActionResult> GetCountOfActiveUsers(CancellationToken cancellationToken)
        {
            try
            {
                var result = await Service.getCountCurrentMonthReservations(cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }

        [Authorize]
        [HttpPut("status/{id}")]
        public async Task<IActionResult> UpdateReservationStatusByClient(int id, CancellationToken cancellationToken)
        {
            var result = await Service.SetReservationToConfirmedOrCancelled(id, cancellationToken);

            if (!result.IsValid)
                return BadRequest(result);

            return Ok(result);
        }


        [Authorize]
        [HttpPut("toCanceled/{id}")]
        public async Task<IActionResult> UpdateReservation(int id, CancellationToken cancellationToken)
        {
            try
            {
                var result =  Service.SetToCancelFromCreated(id, cancellationToken);
                return Ok(result);
            }
            catch (Exception e)
            {
                Logger.LogError(e, "Problem with getting resources");
                return BadRequest();
            }
        }

        #region Hangfire

        [HttpPost("AutoSetCancelReservation")]
        public ActionResult AutoSetCancelReservation()
        {
            RecurringJob.AddOrUpdate(
            "Run every 5 minutes//AutoSetCancelReservation",
            () => Service.AutoSetToCancelIfNotConfirmed(),
            "*/5 * * * *"
                );

            return Ok();
        }
        [HttpPost("AutoSetReservationToUsed")]
        public ActionResult AutoSetReservationToUsed()
        {
            RecurringJob.AddOrUpdate(
            "Run every 3 minutes//AutoSetUsedReservation",
            () => Service.AutoSetReservationToUsed(),
            "*/3 * * * *"
                );

            return Ok();
        }

        #endregion
    }
}
