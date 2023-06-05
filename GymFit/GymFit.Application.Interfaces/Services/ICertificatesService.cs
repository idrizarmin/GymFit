using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface ICertificatesService : IBaseService<int, CertificateDto, CertificateUpsertDto, BaseSearchObject>
    {
    }
}
