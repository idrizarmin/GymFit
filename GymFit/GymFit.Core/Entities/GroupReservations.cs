namespace GymFit.Core
{
    public class GroupReservations : BaseEntity
    {
       
        public DateTime ConfirmationDate { get; set; }
        public bool Arrived { get; set; }

        public int ReservationId { get; set; }
        public Reservation Reservation { get; set; }
        public int PersonId { get; set; }
        public User User { get; set; }
    }
}
