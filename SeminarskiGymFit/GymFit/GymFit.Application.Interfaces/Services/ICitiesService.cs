using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application.Interfaces
{
    public interface ICitiesService : IBaseService<int,CityDto,CityUpsertDto,CitiesSearchObject>
    {
        //Task<IEnumerable<CityDto>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default);
    }
}
