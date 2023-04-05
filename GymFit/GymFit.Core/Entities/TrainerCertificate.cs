namespace GymFit.Core
{
    public class TrainerCertificate : BaseEntity 
    {
        public string Title { get; set; }
        public DateTime DateOfAchievement { get; set; }
        public int TrainerId { get; set; }
        public User Trainer { get; set; }

        public int CertificateId { get; set; }
        public Certificates Certificate { get; set; }
    }
}
