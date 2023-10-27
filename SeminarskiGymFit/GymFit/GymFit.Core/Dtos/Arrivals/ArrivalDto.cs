namespace GymFit.Core
{
    public class ArrivalDto : BaseDto
    {
        public DateTime ArrivalTime { get; set; }
        public DateTime? DepartureTime { get; set; }

        public int ReservationId { get; set; }
        public ReservationDto Reservation { get; set; } = null!;

        public int GymId { get; set; }
        public GymDto Gym { get; set; } = null!;

        public int UserPackageId { get; set; }
        public UserPackageDto UserPackage { get; set; } = null!;

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
