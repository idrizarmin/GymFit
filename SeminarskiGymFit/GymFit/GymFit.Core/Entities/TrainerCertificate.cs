namespace GymFit.Core
{
    public class TrainerCertificate : BaseEntity 
    {
        public string Title { get; set; } = null!;
        public DateTime DateOfAchievement { get; set; }
        public string Issuer { get; set; } = null!;


        public int TrainerId { get; set; }
        public User Trainer { get; set; } = null!;

        public int CertificateId { get; set; }
        public Certificates Certificate { get; set; } = null!;
    }
}
