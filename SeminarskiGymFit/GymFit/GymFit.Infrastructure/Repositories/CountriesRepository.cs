using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure
{
    public class CountriesRepository : BaseRepository<Country, int, CountriesSearchObject>, ICountriesRepository
    {
        public CountriesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<Country>> GetPagedAsync(CountriesSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(s => searchObject.name == null || s.Name.ToLower().Contains(searchObject.name.ToLower())).ToPagedListAsync(searchObject, cancellationToken);
        }

       
    }
}
