namespace GymFit.Core
{
    public class GroupReservationDto : BaseDto
    {
        public DateTime ConfirmationDate { get; set; }
        public bool Arrived { get; set; }

        public int ReservationId { get; set; }
        public ReservationDto Reservation { get; set; } = null!;

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
