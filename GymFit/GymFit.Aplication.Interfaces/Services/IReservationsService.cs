using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IReservationsService : IBaseService<int, ReservationDto, ReservationUpsertDto, BaseSearchObject>
    {
    }
}
