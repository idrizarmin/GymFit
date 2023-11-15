using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class ReservationSearchObject : BaseSearchObject
    {
        public Gender? spol { get; set; }
        public long? userId { get; set; }
        public long? trainerId { get; set; }
    }
}
