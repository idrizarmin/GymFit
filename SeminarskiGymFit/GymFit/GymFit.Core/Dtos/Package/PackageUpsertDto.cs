namespace GymFit.Core
{
    public class PackageUpsertDto : BaseUpsertDto
    {
        public string name { get; set; }
        public string description { get; set; }
        public decimal price { get; set; }
    }
}
