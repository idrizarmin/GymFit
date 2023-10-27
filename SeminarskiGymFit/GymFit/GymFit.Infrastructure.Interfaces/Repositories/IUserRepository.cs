using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserRepository : IBaseRepository<User, int, BaseSearchObject>
    {
        Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
    }
}
