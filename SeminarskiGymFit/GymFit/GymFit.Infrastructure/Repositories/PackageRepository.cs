using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
namespace GymFit.Infrastructure
{
    public class PackageRepository : BaseRepository<Package, int, BaseSearchObject>, IPackageRepository
    {
        public PackageRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
