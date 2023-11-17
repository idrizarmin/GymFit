using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class ReservationSearchObject : BaseSearchObject
    {
        //dodati filter za status umjesto za spol 
        public Gender? spol { get; set; }
        public long? userId { get; set; }
        public long? trainerId { get; set; }
    }
}
