using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IReservationsRepository : IBaseRepository<Reservation, int, ReservationSearchObject>
    {
        Task<List<Reservation>> GetAllFiltered(ReservationSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<int>> GetCountByMonth(ReservationBarChartSearchObject searchObject, CancellationToken cancellationToken= default);
        int getCountCurrentMonthReservations(CancellationToken cancellationToken = default);
        Task<List<Reservation>> GetAllReservationsStatusCreated(CancellationToken cancellationToken = default);
        Task<List<Reservation>> GetAllReservationsStatusConfirmed(CancellationToken cancellationToken = default);
    }
}
