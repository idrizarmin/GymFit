using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IPostService : IBaseService<int,PostDto,PostUpsertDto,BaseSearchObject>
    {
    }
}
