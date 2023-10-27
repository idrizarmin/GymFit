namespace GymFit.Core
{
    public class ClientProgresDto : BaseDto
    {
        public decimal? Height { get; set; }
        public decimal? Weight { get; set; }
        public decimal? Shoulders { get; set; }
        public decimal? Arms { get; set; }
        public decimal? Chest { get; set; }
        public decimal? Stomach { get; set; }
        public decimal? Waist { get; set; }
        public decimal? Hips { get; set; }
        public decimal? Quadriceps { get; set; }
        public decimal? Calf { get; set; }
        public decimal? BMI { get; set; }

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
