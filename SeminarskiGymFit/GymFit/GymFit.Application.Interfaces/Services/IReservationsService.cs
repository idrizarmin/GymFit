using GymFit.Core;
using GymFit.Core.Enums;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface IReservationsService : IBaseService<int, ReservationDto, ReservationUpsertDto, ReservationSearchObject>
    {
        Task<List<ReservationDto>> GetAllFilteredAsync(ReservationSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<List<int>> GetCountByMonthAsync(ReservationBarChartSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<int> getCountCurrentMonthReservations(CancellationToken cancellationToken = default);
        Task<Message> SetReservationToConfirmedOrCancelled(int id, CancellationToken cancellationToken);
        Task SetToCancelFromCreated(int id, CancellationToken cancellationToken);

        Task AutoSetToCancelIfNotConfirmed();

        Task AutoSetReservationToUsed();


    }
}
