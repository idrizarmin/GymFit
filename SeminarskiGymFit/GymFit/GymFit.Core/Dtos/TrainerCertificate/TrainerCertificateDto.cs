namespace GymFit.Core
{
    public  class TrainerCertificateDto : BaseDto 
    {
        public string Title { get; set; } = null!;
        public DateTime DateOfAchievement { get; set; }
        public string Issuer { get; set; } = null!;


        public int TrainerId { get; set; }
        public UserDto Trainer { get; set; } = null!;

        public int CertificateId { get; set; }
        public CertificateDto Certificate { get; set; } = null!;
    }
}
