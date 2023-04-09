using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class TrainerCertificatesRepository : BaseRepository<TrainerCertificate, int, BaseSearchObject>, ITrainerCertificatesRepository
    {
        public TrainerCertificatesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
