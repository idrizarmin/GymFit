using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface ICertificatesService : IBaseService<int, CertificateDto, CertificateUpsertDto, BaseSearchObject>
    {
    }
}
