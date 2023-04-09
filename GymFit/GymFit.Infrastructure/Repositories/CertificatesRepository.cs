using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class CertificatesRepository : BaseRepository<Certificates, int, BaseSearchObject>, ICertificatesRepository
    {
        public CertificatesRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
