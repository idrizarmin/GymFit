using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface ICountriesService :IBaseService<int,CountryDto,CountryUpsertDto,BaseSearchObject>
    {
    }
}
