using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Hangfire;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class UserPackagesController : BaseCrudController<UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackagesService>
    {
        public UserPackagesController(IUserPackagesService service, ILogger<UserPackagesController> logger) : base(service, logger)
        {
        }


        [Authorize]
        [HttpGet("GetAllPaged")]
        public async Task<IActionResult> GetallPagedAsync([FromQuery] UserPackageSearchObject searchObject, CancellationToken cancellationToken)
        {

            try
            {
                var dto = await Service.GetPagedAllAsync(searchObject, cancellationToken);
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
        public async Task<IActionResult> GetUserPckagesByMonth([FromQuery] BarChartSearchObject searchObject, CancellationToken cancellationToken)
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



        [HttpPost("setExpired")]
        public ActionResult setExpired()
        {
            RecurringJob.AddOrUpdate(
            "Run at 00:20 every day//AutoSetExpired",
            () => Service.AutoSetUserPackeExpired(),
            "30 0 * * *"
                );

            return Ok();
        }
    }
}
