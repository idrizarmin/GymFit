namespace GymFit.Core
{
    public class UserPackageUpsertDto : BaseUpsertDto
    {
        public int? PauseDuration { get; set; }
        public bool IsPaused { get; set; }
        public bool Expired { get; set; }
        public DateTime? ActivationDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? PausedOnDate { get; set; }
        public DateTime? ActivateOnDate { get; set; }

        public int UserId { get; set; }
    }
}
