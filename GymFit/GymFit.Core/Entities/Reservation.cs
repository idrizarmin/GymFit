namespace GymFit.Core
{
    public class Reservation:BaseEntity
    {
        
        public string Description { get; set; }
        public DateTime ReservationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int Duration { get; set; }
        public int PauseDuration { get; set; }

        public int CompanyId { get; set; }
        public Gym Company { get; set; }

        public int CustomerId { get; set; }
        public User Customer { get; set; }
    }
}
