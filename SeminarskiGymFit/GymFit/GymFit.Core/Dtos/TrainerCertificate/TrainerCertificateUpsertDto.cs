namespace GymFit.Core
{
    public class TrainerCertificateUpsertDto : BaseUpsertDto
    {
        public string Title { get; set; } = null!;
        public DateTime DateOfAchievement { get; set; }
        public string Issuer { get; set; } = null!;


        public int TrainerId { get; set; }
        public int CertificateId { get; set; }
    }
}
