using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class UserPackageRepository : BaseRepository<UserPackage, int, BaseSearchObject>, IUserPackageRepository
    {
        public UserPackageRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public Task<List<UserPackage>> GetAllUserPackages(int id, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.IsDeleted== false && x.UserId== id && x.ActivateOnDate!=null && !x.Expired ).ToListAsync(cancellationToken);
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
    }
}
