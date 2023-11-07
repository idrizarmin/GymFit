using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface ICitiesRepository : IBaseRepository<City, int, CitiesSearchObject>
    {
       // Task<IEnumerable<City>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default);
    }
}
