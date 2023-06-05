using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using System.Runtime.InteropServices;

namespace GymFit.Api.Controllers
{
    public class ClientProgresesController : BaseCrudController<ClientProgresDto, ClientProgresUpsertDto, BaseSearchObject, IClientProgresService>
    {
        public ClientProgresesController(IClientProgresService service, ILogger<ClientProgresesController> logger) : base(service, logger)
        {
        }
    }
}
