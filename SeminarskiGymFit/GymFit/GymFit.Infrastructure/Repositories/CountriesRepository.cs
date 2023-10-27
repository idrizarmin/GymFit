using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class CountriesRepository : BaseRepository<Country, int, BaseSearchObject>, ICountriesRepository
    {
        public CountriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
