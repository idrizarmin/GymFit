using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{ 
    public interface IClientProgresService : IBaseService<int, ClientProgresDto, ClientProgresUpsertDto, BaseSearchObject>
    {
    }
}
