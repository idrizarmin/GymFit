using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IGroupReservationsService : IBaseService<int, GroupReservationDto, GroupReservationUpsertDto, BaseSearchObject>
    {
    }
}
