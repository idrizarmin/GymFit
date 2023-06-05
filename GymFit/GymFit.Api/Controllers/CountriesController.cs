using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class CountriesController : BaseCrudController<CountryDto, CountryUpsertDto, BaseSearchObject, ICountriesService>
    {
        public CountriesController(ICountriesService service, ILogger<CountriesController> logger) : base(service, logger)
        {
        }
    }
}
