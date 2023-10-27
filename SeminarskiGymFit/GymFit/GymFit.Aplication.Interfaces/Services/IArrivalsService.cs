using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IArrivalsService : IBaseService<int,ArrivalDto, ArrivalUpsertDto,BaseSearchObject>
    {
    }
}
