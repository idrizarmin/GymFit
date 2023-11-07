namespace GymFit.Core
{
    public class NotificationDto : BaseDto
    {
        public string Content { get; set; } = null!;
        public bool? Read { get; set; } = false;
        public bool? Deleted { get; set; } = false;
        public DateTime? DateRead { get; set; }
        public DateTime? SendOnDate { get; set; }
        public DateTime? Seen { get; set; }

        public int UserId { get; set; }
        public UserDto User { get; set; } = null!;
    }
}
