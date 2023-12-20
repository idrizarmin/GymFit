namespace GymFit.Core
{
    public class UserUpsertDto : BaseUpsertDto
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string? Password { get; set; }
        public string Email { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string? ProfessionalTitle { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }
        public Gender Gender { get; set; }
        public DateTime DateOfBirth { get; set; }
        public Role Role { get; set; }

        public int photoId { get; set; }
    }
}
