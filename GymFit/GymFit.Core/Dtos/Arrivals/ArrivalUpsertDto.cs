namespace GymFit.Core
{
    public class ArrivalUpsertDto :BaseUpsertDto
    {
        public DateTime ArrivalTime { get; set; }
        public DateTime? DepartureTime { get; set; }

        public int ReservationId { get; set; }

        public int GymId { get; set; }

        public int UserPackageId { get; set; }

        public int UserId { get; set; }
    }
}
