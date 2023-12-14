using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class PackageController : BaseCrudController<PackageDto, PackageUpsertDto, BaseSearchObject, IPackageService>
    {
        public PackageController(IPackageService service, ILogger<PackageController> logger) : base(service, logger)
        {
        }
    }
}
