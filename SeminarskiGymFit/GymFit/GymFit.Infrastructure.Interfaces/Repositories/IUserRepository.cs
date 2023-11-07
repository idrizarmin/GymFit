using GymFit.Core;
using GymFit.Core.Dtos.User;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserRepository : IBaseRepository<User, int, UserSearchObject>
    {
        Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        int getCountOfUsers(CancellationToken cancellationToken = default);
        int getCountOfUsersActive(int cinemaId, CancellationToken cancellationToken = default);
        int getCountOfUsersInactive(int cinemaId, CancellationToken cancellationToken = default);
        Task<List<User?>> GetUsersForSelection(CancellationToken cancellationToken = default);

    }
}
