using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class PackageService : BaseService<Package, PackageDto, PackageUpsertDto, BaseSearchObject, IPackageRepository>, IPackageService
    {
        public PackageService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PackageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
