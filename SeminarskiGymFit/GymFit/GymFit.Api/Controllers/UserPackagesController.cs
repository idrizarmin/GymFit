using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class UserPackagesController : BaseCrudController<UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackagesService>
    {
        public UserPackagesController(IUserPackagesService service, ILogger<UserPackagesController> logger) : base(service, logger)
        {
        }
    }
}
