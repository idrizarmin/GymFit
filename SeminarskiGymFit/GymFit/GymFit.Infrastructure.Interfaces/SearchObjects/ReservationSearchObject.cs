using GymFit.Core;
using GymFit.Core.Enums;

namespace GymFit.Infrastructure.Interfaces.SearchObjects
{
    public class ReservationSearchObject : BaseSearchObject
    {
        //dodati filter za status umjesto za spol 
        public Gender? spol { get; set; }
        public ReservationStatus? status { get; set; }
        public long? userId { get; set; }
        public long? trainerId { get; set; }
    }
}
