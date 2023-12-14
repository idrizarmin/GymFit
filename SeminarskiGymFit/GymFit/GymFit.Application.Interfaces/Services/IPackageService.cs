using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public   interface  IPackageService : IBaseService<int,PackageDto,PackageUpsertDto, BaseSearchObject>
    {
    }
}
