using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class PostController : BaseCrudController<PostDto, PostUpsertDto, BaseSearchObject, IPostService>
    {
        public PostController(IPostService service, ILogger<PostController> logger) : base(service, logger)
        {
        }
    }
}
