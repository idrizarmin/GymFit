using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class ArrivalsController : BaseCrudController<ArrivalDto, ArrivalUpsertDto, BaseSearchObject, IArrivalsService>
    {
        public ArrivalsController(IArrivalsService service, ILogger<ArrivalsController> logger) : base(service, logger)
        {
        }
    }
}
