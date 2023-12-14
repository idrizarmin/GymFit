using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class UserPackagesService : BaseService<UserPackage, UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackageRepository>, IUserPackagesService
    {
        public UserPackagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserPackageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
