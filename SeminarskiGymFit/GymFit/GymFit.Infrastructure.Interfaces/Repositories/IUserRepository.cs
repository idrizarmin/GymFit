using GymFit.Core;
using GymFit.Core.Dtos.User;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserRepository : IBaseRepository<User, int, UserSearchObject>
    {
        Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        int getCountOfUsersAsync(CancellationToken cancellationToken = default);
        int getCountOfUsersActiveAsync(CancellationToken cancellationToken = default);
        int getCountOfUsersInactiveAsync(CancellationToken cancellationToken = default);
        Task<List<User?>> GetUsersForSelection(CancellationToken cancellationToken = default);
        Task<List<User?>> GetTrainersForSelection(CancellationToken cancellationToken = default);
        Task<List<User?>> GetAllTrainers(CancellationToken cancellationToken = default);

        Task<PagedList<User>> GetAdminsPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<PagedList<User>> GetTrainersPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default);

    }
}
