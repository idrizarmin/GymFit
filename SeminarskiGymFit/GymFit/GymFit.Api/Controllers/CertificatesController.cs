using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class CertificatesController : BaseCrudController<CertificateDto, CertificateUpsertDto, BaseSearchObject, ICertificatesService>
    {
        public CertificatesController(ICertificatesService service, ILogger<CertificatesController> logger) : base(service, logger)
        {
        }
    }
}
