using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface ICitiesRepository : IBaseRepository<City, int, BaseSearchObject>
    {
        Task<IEnumerable<City>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default);
    }
}
