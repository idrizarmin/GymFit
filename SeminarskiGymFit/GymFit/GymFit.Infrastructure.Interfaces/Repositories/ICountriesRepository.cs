using GymFit.Core;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface ICountriesRepository : IBaseRepository<Country, int, CountriesSearchObject>
    {
    }
}
