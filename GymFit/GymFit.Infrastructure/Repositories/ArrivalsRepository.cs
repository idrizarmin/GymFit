using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class ArrivalsRepository : BaseRepository<Arrivals, int, BaseSearchObject>, IArrivalsRepository
    {
        public ArrivalsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
