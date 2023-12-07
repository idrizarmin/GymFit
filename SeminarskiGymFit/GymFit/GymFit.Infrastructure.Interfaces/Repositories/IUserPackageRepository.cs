using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserPackageRepository : IBaseRepository<UserPackage, int, BaseSearchObject>
    {
        Task<UserPackage> GetUserPackage(int id,CancellationToken cancellationToken = default);
    }
}
