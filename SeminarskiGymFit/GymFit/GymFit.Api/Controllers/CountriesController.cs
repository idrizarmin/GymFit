using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Api.Controllers
{
    public class CountriesController : BaseCrudController<CountryDto, CountryUpsertDto, CountriesSearchObject, ICountriesService>
    {
        public CountriesController(ICountriesService service, ILogger<CountriesController> logger) : base(service, logger)
        {
        }
    }
}
