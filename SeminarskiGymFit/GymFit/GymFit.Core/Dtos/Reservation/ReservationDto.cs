using GymFit.Core.Enums;

namespace GymFit.Core
{
    public class ReservationDto : BaseDto
    {
        public string Description { get; set; } = null!;
        public DateTime ReservationDate { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int? Duration { get; set; }
        public int? PauseDuration { get; set; }
        public int? MaxCapacity { get; set; }
        public ReservationStatus Status { get; set; }

        public string? DaysOfWeek { get; set; } = null!;
        public bool? isUsed { get; set; }

        public int GymId { get; set; }
        public GymDto Gym { get; set; } = null!;

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;

        public int? TrainerId { get; set; }
        public UserDto? Trainer { get; set; } = null!;

    }
}
