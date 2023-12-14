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
//public class CitiesService : BaseService<City, CityDto, CityUpsertDto, CitiesSearchObject, ICitiesRepository>, ICitiesService
//{
//    public CitiesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<CityUpsertDto> validator) : base(mapper, unitOfWork, validator)
//    {
//    }
//    //public async Task<IEnumerable<CityDto>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default)
//    //{
//    //    var cities = await CurrentRepository.GetByCountryIdAsync(countryId, cancellationToken);

//    //    return Mapper.Map<IEnumerable<CityDto>>(cities);
//    //}
//}
//}
