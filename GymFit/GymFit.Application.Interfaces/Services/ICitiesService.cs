using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface ICitiesService : IBaseService<int,CityDto,CityUpsertDto,BaseSearchObject>
    {
        Task<IEnumerable<CityDto>> GetByCountryIdAsync(int countryId, CancellationToken cancellationToken = default);
    }
}
