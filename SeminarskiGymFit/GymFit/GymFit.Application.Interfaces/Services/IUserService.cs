using GymFit.Core;
using GymFit.Core.Dtos.User;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface IUserService : IBaseService<int, UserDto, UserUpsertDto, UserSearchObject>
    {
        Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
        Task ChangePassword(UserChangePasswordDto dto, CancellationToken cancellationToken);
        Task<int> getCountOfUsersAsync(CancellationToken cancellationToken = default);
        Task<int> getCountOfUsersActiveAsync(CancellationToken cancellationToken = default);
        Task<int> getCountOfUsersInactiveAsync(CancellationToken cancellationToken = default);
        Task<List<UserForSelectionDto?>> GetUserForSelectionAsync(CancellationToken cancellationToken = default);
        Task<List<UserForSelectionDto?>> GetTrainersForSelectionAsync(CancellationToken cancellationToken = default);

        Task<PagedList<UserDto>> GetAdminsPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<PagedList<UserDto>> GetTrainersPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default);

    }
}
