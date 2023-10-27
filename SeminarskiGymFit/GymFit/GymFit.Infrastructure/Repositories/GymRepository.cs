using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class GymRepository : BaseRepository<Gym, int, BaseSearchObject>, IGymRepository
    {
        public GymRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
