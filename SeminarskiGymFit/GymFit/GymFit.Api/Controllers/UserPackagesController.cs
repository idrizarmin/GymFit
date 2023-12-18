using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Hangfire;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class UserPackagesController : BaseCrudController<UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackagesService>
    {
        public UserPackagesController(IUserPackagesService service, ILogger<UserPackagesController> logger) : base(service, logger)
        {
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
