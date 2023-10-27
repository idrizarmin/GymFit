namespace GymFit.Core
{
    public class CertificateUpsertDto : BaseUpsertDto
    {
        public string Title { get; set; } = null!;
        public string Issuer { get; set; } = null!;
    }
}
