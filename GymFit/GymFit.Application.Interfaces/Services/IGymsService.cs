using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IGymsService : IBaseService<int, GymDto, GymUpsertDto, BaseSearchObject>
    {
    }
}
