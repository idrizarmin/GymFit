using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IArrivalsService : IBaseService<int,ArrivalDto, ArrivalUpsertDto,BaseSearchObject>
    {
    }
}
