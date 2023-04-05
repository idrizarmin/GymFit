namespace GymFit.Core
{
    public  class User :BaseEntity
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
       
        public string PhoneNumber { get; set; }
        public string Address { get; set; }
       
        public string ProfessionalTitle { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }
        public Gender Gender { get; set; }
        public DateTime DateOfBirth { get; set; }
        public float Height { get; set; }
        public float Weight { get; set; }
        public Role Role  { get; set; }
        public string PasswordHash { get; set; }
        public string PasswordSalt { get; set; }

        public int GymId { get; set; }
        public Gym Company { get; set; }

        public int CityId { get; set; }
        public City City { get; set; }

        public int? PhotoId { get; set; }
        public Photo? Photo { get; set; }
    }
}
