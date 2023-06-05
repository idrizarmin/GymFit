using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{ 
    public interface IClientProgresService : IBaseService<int, ClientProgresDto, ClientProgresUpsertDto, BaseSearchObject>
    {
    }
}
