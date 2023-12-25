namespace GymFit.Core
{
    public class Gym: BaseEntity
    {
        public string Name { get; set; } = null!;
        public string Address { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string PhoneNumber { get; set; } = null!;
        public string? Website { get; set; } 

      

        public ICollection<Arrivals> Arrivals { get; set; } = null!;
        public ICollection<Reservation> Reservations { get; set; } = null!;
    }
}
