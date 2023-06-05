using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class TrainerCertificatesController : BaseCrudController<TrainerCertificateDto, TrainerCertificateUpsertDto, BaseSearchObject, ITrainerCertificatesService>
    {
        public TrainerCertificatesController(ITrainerCertificatesService service, ILogger<TrainerCertificatesController> logger) : base(service, logger)
        {
        }
    }
}
