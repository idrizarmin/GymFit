namespace GymFit.Core
{
    public class ReservationUpsertDto :BaseUpsertDto
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

        public int UserId { get; set; }

        public int TrainerId { get; set; }
    }
}
