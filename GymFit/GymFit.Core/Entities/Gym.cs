namespace GymFit.Core
{
    public class Gym: BaseEntity
    {
        public string Name { get; set; }
       
        public string Address { get; set; }
        public string Description { get; set; }
        public string PhoneNumber { get; set; }
        public string Website { get; set; }

        public int CityId { get; set; }
        public City City { get; set; }

    }
}
