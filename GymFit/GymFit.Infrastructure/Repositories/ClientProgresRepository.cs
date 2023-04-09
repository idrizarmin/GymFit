using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class ClientProgresRepository : BaseRepository<ClientProgress, int, BaseSearchObject>,IClientProgresRepository
    {
        public ClientProgresRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
