using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading;

namespace GymFit.Infrastructure
{
    public class UserRepository : BaseRepository<User, int, UserSearchObject>, IUserRepository
    {
        public UserRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(u => u.Email == email, cancellationToken);
        }
        public int getCountOfUsers(CancellationToken cancellationToken = default)
        {
            return DbSet.AsNoTracking().Count();
        }

        public int getCountOfUsersActive(int cinemaId, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(s => s.IsActive == true).AsNoTracking().Count();

        }
        

        public int getCountOfUsersInactive(int cinemaId, CancellationToken cancellationToken = default)
        {
            return DbSet.Where(s => s.IsActive == false).AsNoTracking().Count();
        }
       public async Task<List<User>> GetUsersForSelection(CancellationToken cancellationToken = default)
        {

            return await DbSet.Where(u=>u.Role == Role.Korisnik).ToListAsync(cancellationToken);
            
            //return await DbSet.Where(u=>u.Role == Role.Trener).ToListAsync(cancellationToken);

            //return await DbSet.Where(u => u.Role == Role.Trener).ToListAsync(cancellationToken);


        }
        public override async Task<PagedList<User>> GetPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(u => u.Photo).Where(u =>
                 (searchObject.name == null
                 || u.FirstName.ToLower().Contains(searchObject.name.ToLower())
                 || u.LastName.ToLower().Contains(searchObject.name.ToLower()))
                 && (searchObject.isActive == null || u.IsActive == searchObject.isActive)
                 && (searchObject.spol == null ||u.Gender == searchObject.spol)
                 && (searchObject.isVerified == null || u.IsVerified == searchObject.isVerified))
                    .ToPagedListAsync(searchObject, cancellationToken);
        }

    }
}

