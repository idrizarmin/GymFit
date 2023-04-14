namespace GymFit.Core
{
    public class GroupReservationUpsertDto : BaseUpsertDto
    {
        public DateTime ConfirmationDate { get; set; }
        public bool Arrived { get; set; }

        public int ReservationId { get; set; }

        public int UserId { get; set; }
    }
}
