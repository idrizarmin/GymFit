namespace GymFit.Core
{
    public  class User :BaseEntity
    {
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string? ProfessionalTitle { get; set; }
        public bool IsVerified { get; set; }
        public bool IsActive { get; set; }
        public Gender Gender { get; set; }
        public DateTime DateOfBirth { get; set; }
        public Role Role  { get; set; }
        public string PasswordHash { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;

        public int CityId { get; set; }
        public City City { get; set; } = null!;

        public int? PhotoId { get; set; }
        public Photo? Photo { get; set; }

        public ICollection<Arrivals> Arrivals { get; set; } = null!;
        public ICollection<TrainerCertificate> TrainerCertificates { get; set; } = null!;
        public ICollection<Notification> Notifications { get; set; } = null!;
        public ICollection<UserPackage> UserPackages { get; set; } = null!;
        public ICollection<GroupReservations> GroupReservations { get; set; } = null!;
        public ICollection<Reservation> TrainerReservations { get; set; } = null!;
        public ICollection<Reservation> UserReservations { get; set; } = null!;
        public ICollection<ClientProgress> ClientProgress { get; set; } = null!;
    }
}
