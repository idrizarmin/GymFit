using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface IReservationsService : IBaseService<int, ReservationDto, ReservationUpsertDto, ReservationSearchObject>
    {
        Task<List<ReservationDto>> GetAllFilteredAsync(ReservationSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<int>> GetCountByMonthAsync(ReservationBarChartSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<int> getCountCurrentMonthReservations(CancellationToken cancellationToken = default);


    }
}
