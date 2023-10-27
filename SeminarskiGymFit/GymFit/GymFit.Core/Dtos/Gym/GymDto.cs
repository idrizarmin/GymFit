namespace GymFit.Core
{
    public class GymDto : BaseDto
    {
        public string Name { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string? Website { get; set; }

        public int CityId { get; set; }
        public CityDto City { get; set; } = null!;

        public int PhotoId { get; set; }
        public PhotoDto Photo { get; set; } = null!;
    }
}
