namespace GymFit.Core
{
    public class Reservation:BaseEntity
    {
        public string Description { get; set; } = null!;
        public DateTime ReservationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Duration { get; set; }
        public int PauseDuration { get; set; }
        public int MaxCapacity { get; set; }
        public string DaysOfWeek { get; set; } = null!;
        public bool isUsed { get; set; }

        public int GymId { get; set; }
        public Gym Gym { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        public int TrainerId { get; set; }
        public User Trainer { get; set; } = null!;

        public ICollection<Arrivals> Arrivals { get; set; } = null!;
        public ICollection<GroupReservations> GroupReservations { get; set; } = null!;
    }
}
