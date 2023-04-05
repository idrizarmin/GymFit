namespace GymFit.Core
{
    public class Arrivals :BaseEntity
    {
       
        public DateTime ArrivalTime { get; set; }
        public DateTime? DepartureTime { get; set; }

        public int ReservationId { get; set; }
        public Reservation Reservation { get; set; }

        public int GymId { get; set; }
        public Gym Gym { get; set; }

        public int PaketId { get; set; }
        public UserPackage UserPackage { get; set; }

        public int PersonId { get; set; }
        public User User { get; set; }
    }
}
