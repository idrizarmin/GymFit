using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IUserService : IBaseService<int, UserDto, UserUpsertDto, BaseSearchObject>
    {
        Task<UserSensitiveDto?> GetByEmailAsync(string email, CancellationToken cancellationToken = default);
    }
}
