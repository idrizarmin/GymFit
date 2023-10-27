using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces.Services
{
    public interface ICountriesService :IBaseService<int,CountryDto,CountryUpsertDto,BaseSearchObject>
    {
    }
}
