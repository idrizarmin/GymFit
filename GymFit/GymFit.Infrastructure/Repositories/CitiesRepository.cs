using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class CitiesRepository : BaseRepository<City, int, BaseSearchObject>, ICitiesRepository
    {
        public CitiesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public async Task<IEnumerable<City>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().Where(c => c.CountryId == countryId).ToListAsync(cancellationToken);
        }
    }
}
