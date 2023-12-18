using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Core.Enums;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class UserPackagesService : BaseService<UserPackage, UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackageRepository>, IUserPackagesService
    {
        public UserPackagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserPackageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task AutoSetUserPackeExpired()
        {
            var userPackages = await CurrentRepository.GetAllUserPackages();

            {
                try
                {
                    if (userPackages != null)
                    {
                        foreach (var userPackage in userPackages)
                        {
                            if (userPackage.ExpirationDate < DateTime.Now)
                            {

                                userPackage.Expired = true;
                                CurrentRepository.Update(userPackage);
                            }

                        }

                    }
                    await UnitOfWork.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
        }
    }
}
