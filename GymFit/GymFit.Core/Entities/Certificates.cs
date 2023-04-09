namespace GymFit.Core
{
    public class Certificates :BaseEntity
    {
        public string Title { get; set; } = null!;
        public string Issuer { get; set; } = null!;

        public ICollection<TrainerCertificate> TrainerCertificates { get; set; } = null!;
    }
}
