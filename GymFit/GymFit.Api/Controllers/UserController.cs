using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class UserController : BaseCrudController<UserDto, UserUpsertDto, BaseSearchObject, IUserService>
    {
        public UserController(IUserService service, ILogger<UserController> logger) : base(service, logger)
        {
        }

    }
}
