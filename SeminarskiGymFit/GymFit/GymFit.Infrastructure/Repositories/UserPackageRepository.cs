using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class UserPackageRepository : BaseRepository<UserPackage, int, UserPackageSearchObject>, IUserPackageRepository
    {
        public UserPackageRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public override async Task<PagedList<UserPackage>> GetPagedAsync(UserPackageSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(s => s.package)
                .Where(u => (u.Expired== searchObject.expired))
                .ToPagedListAsync(searchObject, cancellationToken);


        }

        public Task<List<UserPackage>> GetAllUserPackages(CancellationToken cancellationToken = default)
        {
            return DbSet.ToListAsync(cancellationToken);
        }
      
        public async Task<UserPackage?> GetUserPackage(int id, CancellationToken cancellationToken = default)
        {

           
                var userPackage = await DbSet.Where(x => x.IsDeleted == false && x.UserId == id && x.ActivateOnDate != null && !x.Expired).FirstOrDefaultAsync(cancellationToken);

            if (userPackage == null)
            {
                return userPackage;
            }
            else
                return null;

         
        }

        public async Task<List<int>> GetCountByMonth(BarChartSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var counts = await DbSet
                .Where(r => r.CreatedAt.Year == searchObject.year)
                .GroupBy(r => r.CreatedAt.Month)
                .Select(group => new
                {
                    Month = group.Key,
                    Count = group.Count()
                })
                .OrderBy(result => result.Month)
                .ToListAsync(cancellationToken);

            List<int> result = new List<int>();

            for (int month = 1; month <= 12; month++)
            {
                var count = counts.FirstOrDefault(c => c.Month == month)?.Count ?? 0;
                result.Add(count);
            }

            return result;
        }
    }
}
