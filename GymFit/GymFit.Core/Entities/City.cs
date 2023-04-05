namespace GymFit.Core
{
    public class City :BaseEntity
    {
        public string Name { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }

        public int CountryID { get; set; }
        public Country Country { get; set; }
    }
}
}
