using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IUserPackagesService : IBaseService<int, UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject>
    {
        Task<List<int>> GetCountByMonthAsync(BarChartSearchObject searchObject, CancellationToken cancellationToken = default);

        Task AutoSetUserPackeExpired();
    }
}
