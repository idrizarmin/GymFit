using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class ReservationsRepository : BaseRepository<Reservation, int, ReservationSearchObject>, IReservationsRepository
    {
        public ReservationsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
      
        public async Task<List<Reservation>> GetAllFiltered(ReservationSearchObject searchObject, CancellationToken cancellationToken)
        {
            return await DbSet.Include(u => u.User).Include(t => t.Trainer)
                .Where(n => (searchObject.spol == null || n.User.Gender == searchObject.spol)
                && (searchObject.userId == null || n.UserId == searchObject.userId)
                && (searchObject.trainerId == null || n.TrainerId == searchObject.trainerId))
                .ToListAsync(cancellationToken);
        }
    }
}
