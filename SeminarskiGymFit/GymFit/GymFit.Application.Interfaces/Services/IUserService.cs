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
        Task<List<UserForSelectionDto?>> GetUserForSelectionAsync(CancellationToken cancellationToken = default); 
    }
}
