﻿namespace GymFit.Core
{
    public class UserDto : BaseDto
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string? ProfessionalTitle { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }
        public Gender Gender { get; set; }
        public DateTime DateOfBirth { get; set; } 
        public Role Role { get; set; }
        
        public int? PhotoId { get; set; }
        public PhotoDto? Photo { get; set; }
    }
}
