namespace GymFit.Core
{
    public class UserPackage : BaseEntity 
    {
      
        public int PaketId { get; set; }
        public int? PauseDuration { get; set; }
        public bool IsPaused { get; set; }
        public bool Expired { get; set; }
        public DateTime? ActivationDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? PausedOnDate { get; set; }
        public DateTime? ActivateOnDate { get; set; }

        public int UserId { get; set; }
        public User User { get; set; }
    }
}
