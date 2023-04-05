namespace GymFit.Core
{
    public class Photo : BaseEntity
    {
        public byte[] Data { get; set; } = null!;
        public string ContentType { get; set; } = null!;
    }
}
