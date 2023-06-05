using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IUserPackagesService : IBaseService<int, UserPackageDto, UserPackageUpsertDto, BaseSearchObject>
    {
    }
}
