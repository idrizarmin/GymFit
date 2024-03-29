﻿using GymFit.Core;
using Microsoft.AspNetCore.Http;

namespace GymFit.Api.Models
{
    public class UserUpsertModel
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Password { get; set; }
        public string PhoneNumber { get; set; } = null!;
        public string? Address { get; set; } = null!;
        public string? ProfessionalTitle { get; set; }

        public Gender Gender { get; set; }
        public DateTime DateOfBirth { get; set; }
        public Role Role { get; set; }
        public DateTime? LastSignInAt { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }

        public IFormFile? ProfilePhoto { get; set; }
    }
}
