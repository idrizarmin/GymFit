using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class GymsController : BaseCrudController<GymDto, GymUpsertDto, BaseSearchObject, IGymsService>
    {
        public GymsController(IGymsService service, ILogger<GymsController> logger) : base(service, logger)
        {
        }
    }
}
