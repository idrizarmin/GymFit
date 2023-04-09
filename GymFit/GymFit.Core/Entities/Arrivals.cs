namespace GymFit.Core
{
    public class Arrivals :BaseEntity
    {
        public DateTime ArrivalTime { get; set; }
        public DateTime? DepartureTime { get; set; }

        public int ReservationId { get; set; }
        public Reservation Reservation { get; set; } = null!;

        public int GymId { get; set; }
        public Gym Gym { get; set; } = null!;

        public int UserPackageId { get; set; }
        public UserPackage UserPackage { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
