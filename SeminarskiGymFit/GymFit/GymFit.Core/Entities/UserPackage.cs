namespace GymFit.Core
{
    public class UserPackage : BaseEntity 
    {
        public int? PauseDuration { get; set; }
        public bool IsPaused { get; set; }
        public bool Expired { get; set; }
        public DateTime? ActivationDate { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public DateTime? PausedOnDate { get; set; }
        public DateTime? ActivateOnDate { get; set; }

        public int UserId { get; set; }
        public User User { get; set; } = null!;

        public int packageId { get; set; }
        public Package package { get; set; } = null!;

        public ICollection<Arrivals> Arrivals { get; set; } = null!;
        public ICollection<Transactions> Transactions { get; set; } = null!;

    }
}
