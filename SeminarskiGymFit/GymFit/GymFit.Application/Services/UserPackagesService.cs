using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Core.Enums;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application
{
    public class UserPackagesService : BaseService<UserPackage, UserPackageDto, UserPackageUpsertDto, UserPackageSearchObject, IUserPackageRepository>, IUserPackagesService
    {
        public UserPackagesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<UserPackageUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
       
        public async Task<PagedList<UserPackageDto>> GetPagedAllAsync(UserPackageSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var packages = await CurrentRepository.GetPagedAll(searchObject, cancellationToken);

            return Mapper.Map<PagedList<UserPackageDto>>(packages);
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

        public async Task<List<int>> GetCountByMonthAsync(BarChartSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await CurrentRepository.GetCountByMonth(searchObject, cancellationToken);
        }

      
    }
}
