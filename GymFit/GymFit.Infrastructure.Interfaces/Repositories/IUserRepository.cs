using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserRepository : IBaseRepository<User, int, BaseSearchObject>
    {
    }
}
