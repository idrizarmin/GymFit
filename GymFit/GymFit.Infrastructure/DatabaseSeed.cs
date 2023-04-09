using GymFit.Core;
using Microsoft.EntityFrameworkCore;


namespace GymFit.Infrastructure
{
    public partial class DatabaseContext
    {
        private readonly DateTime _dateTime = new(2023, 2, 1, 0, 0, 0, 0, DateTimeKind.Local);

        private void SeedData(ModelBuilder modelBuilder) 
        {
            SeedCountries(modelBuilder);
        }

        private void SeedCountries(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Country>().HasData(
               new()
               {
                   Id = 1,
                   Name = "Bosnia and Herzegovina",
                   Abbreviation = "BIH",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 2,
                   Name = "Croatia",
                   Abbreviation = "HR",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 3,
                   Name = "Serbia",
                   Abbreviation = "SRB",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 4,
                   Name = "Montenegro",
                   Abbreviation = "CG",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 5,
                   Name = "Slovenia",
                   Abbreviation = "SLO",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               },
               new()
               {
                   Id = 6,
                   Name = "Austria",
                   Abbreviation = "AT",
                   IsActive = true,
                   CreatedAt = _dateTime,
                   ModifiedAt = null
               });
        }
    }
}
