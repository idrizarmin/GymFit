using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IReservationsRepository : IBaseRepository<Reservation, int, ReservationSearchObject>
    {
        Task<List<Reservation>> GetAllFiltered(ReservationSearchObject searchObject, CancellationToken cancellationToken);
    }
}
