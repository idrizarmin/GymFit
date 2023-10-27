using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IGymsService : IBaseService<int, GymDto, GymUpsertDto, BaseSearchObject>
    {
    }
}
