using GymFit.Core;
using GymFit.Core.Enums;
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
      
        public async Task<List<Reservation>> GetAllFiltered(ReservationSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(x=>x.Trainer)
                .Where(n => (searchObject.spol == null || n.User.Gender == searchObject.spol)
                && (searchObject.userId == null || n.UserId == searchObject.userId)
                && (searchObject.trainerId == null || n.TrainerId == searchObject.trainerId)
                && searchObject.status == null || n.Status == searchObject.status)

                .ToListAsync(cancellationToken);
        }
        public int getCountCurrentMonthReservations(CancellationToken cancellationToken = default)
        {
            var currentDate = DateTime.Now;
            return  DbSet.Where(s =>(s.ReservationDate.Month== currentDate.Month)
            && (s.ReservationDate.Year == currentDate.Year)).AsNoTracking().Count();
        }
       
        public async Task<List<int>> GetCountByMonth(BarChartSearchObject searchObject, CancellationToken cancellationToken = default)
        {

            var counts = await DbSet
                .Where(r => r.ReservationDate.Year == searchObject.year)
                .GroupBy(r => r.ReservationDate.Month)
                .Select(group => new
                {
                    Month = group.Key,
                    Count = group.Count()
                })
                .OrderBy(result => result.Month)
                .ToListAsync(cancellationToken);

            List<int> result = new List<int>();

            for (int month = 1; month <= 12; month++)
            {
                var count = counts.FirstOrDefault(c => c.Month == month)?.Count ?? 0;
                result.Add(count);
            }

            return result;
        }

        public Task<List<Reservation>> GetAllReservationsStatusCreated(CancellationToken cancellationToken = default)
        {
           return DbSet.Where(x=> x.Status == ReservationStatus.Created && x.StartDate.AddHours(-3)< DateTime.Now).ToListAsync(cancellationToken) ;
        }
        public Task<List<Reservation>> GetAllReservationsStatusConfirmed(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(x => x.Status == ReservationStatus.Confirmed && x.EndDate.AddMinutes(5) < DateTime.Now).ToListAsync(cancellationToken);
        }
    }
}
