using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IReservationsService : IBaseService<int, ReservationDto, ReservationUpsertDto, BaseSearchObject>
    {
    }
}
