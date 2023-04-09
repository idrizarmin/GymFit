using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class GroupReservationsRepository : BaseRepository<GroupReservations, int, BaseSearchObject>, IGroupReservationsRepository
    {
        public GroupReservationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
