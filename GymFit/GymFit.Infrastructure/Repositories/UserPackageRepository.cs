using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class UserPackageRepository : BaseRepository<UserPackage, int, BaseSearchObject>, IUserPackageRepository
    {
        public UserPackageRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
