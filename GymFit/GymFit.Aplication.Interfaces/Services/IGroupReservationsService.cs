using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IGroupReservationsService : IBaseService<int, GroupReservationDto, GroupReservationUpsertDto, BaseSearchObject>
    {
    }
}
