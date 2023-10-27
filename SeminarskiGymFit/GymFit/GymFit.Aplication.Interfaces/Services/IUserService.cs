using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IUserService : IBaseService<int, UserDto, UserUpsertDto, BaseSearchObject>
    {
    }
}
