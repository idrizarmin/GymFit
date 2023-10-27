using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface ITrainerCertificatesService : IBaseService<int, TrainerCertificateDto, TrainerCertificateUpsertDto, BaseSearchObject>
    {
    }
}
