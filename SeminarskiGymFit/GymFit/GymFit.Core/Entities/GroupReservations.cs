namespace GymFit.Core
{
    public class GroupReservations : BaseEntity
    {
        public DateTime ConfirmationDate { get; set; }
        public bool Arrived { get; set; }

        public int ReservationId { get; set; }
        public Reservation Reservation { get; set; } = null!;

        public int UserId { get; set; }
        public User User { get; set; } = null!;
    }
}
