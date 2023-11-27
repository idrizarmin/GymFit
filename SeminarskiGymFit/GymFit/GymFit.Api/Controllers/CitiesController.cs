using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.AspNetCore.Mvc;

namespace GymFit.Api.Controllers
{
    public class CitiesController : BaseCrudController<CityDto, CityUpsertDto, CitiesSearchObject, ICitiesService>
    {
        public CitiesController(ICitiesService service, ILogger<CitiesController> logger) : base(service, logger)
        {
        }
    }
}
