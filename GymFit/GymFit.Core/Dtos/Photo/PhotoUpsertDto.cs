namespace GymFit.Core
{
    public class PhotoUpsertDto : BaseUpsertDto
    {
        public byte[] Data { get; set; } = null!;
        public string ContentType { get; set; } = null!;
    }
}
