using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface ITrainerCertificatesService : IBaseService<int, TrainerCertificateDto, TrainerCertificateUpsertDto, BaseSearchObject>
    {
    }
}
