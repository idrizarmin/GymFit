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
        public int getCountOfUsersAsync(CancellationToken cancellationToken = default)
        {
            return DbSet.AsNoTracking().Count();
        }

        public int getCountOfUsersActiveAsync(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(s => s.IsActive == true).AsNoTracking().Count();

        }
        

        public int getCountOfUsersInactiveAsync(CancellationToken cancellationToken = default)
        {
            return DbSet.Where(s => s.IsActive == false).AsNoTracking().Count();
        }

       public async Task<List<User>> GetUsersForSelection(CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(u=>u.Role == Role.Korisnik).ToListAsync(cancellationToken); 
        }
        public async Task<List<User>> GetTrainersForSelection(CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(u => u.Role == Role.Trener).ToListAsync(cancellationToken); 
        }
        public async Task<List<User>> GetAllTrainers(CancellationToken cancellationToken = default)
        {
            return await DbSet.Where(u => u.Role == Role.Trener).ToListAsync(cancellationToken);
        }
        public  async Task<PagedList<User>> GetAdminsPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(s => s.Photo)
                 .Where(u => (searchObject.name == null
                 || u.FirstName.ToLower().Contains(searchObject.name.ToLower())
                 || u.LastName.ToLower().Contains(searchObject.name.ToLower()))
                  && (searchObject.isActive == null || u.IsActive == searchObject.isActive)
                  && (searchObject.spol == null || u.Gender == searchObject.spol)
                  && (searchObject.isVerified == null || u.IsVerified == searchObject.isVerified)
                  &&(u.Role == Role.Administrator))
                 .ToPagedListAsync(searchObject, cancellationToken);

        }
        public async Task<PagedList<User>> GetTrainersPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(s => s.Photo)
                 .Where(u => (searchObject.name == null
                 || u.FirstName.ToLower().Contains(searchObject.name.ToLower())
                 || u.LastName.ToLower().Contains(searchObject.name.ToLower()))
                  && (searchObject.isActive == null || u.IsActive == searchObject.isActive)
                  && (searchObject.spol == null || u.Gender == searchObject.spol)
                  && (searchObject.isVerified == null || u.IsVerified == searchObject.isVerified)
                  &&(u.Role== Role.Trener))
                 .ToPagedListAsync(searchObject, cancellationToken);

        }

        public override async Task<PagedList<User>> GetPagedAsync(UserSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            return await DbSet.Include(s=>s.Photo)
                 .Where(u => (searchObject.name == null
                 || u.FirstName.ToLower().Contains(searchObject.name.ToLower())
                 || u.LastName.ToLower().Contains(searchObject.name.ToLower()))
                  && (searchObject.isActive == null || u.IsActive == searchObject.isActive)
                  && (searchObject.spol == null ||u.Gender == searchObject.spol)
                  && (searchObject.isVerified == null || u.IsVerified == searchObject.isVerified)
                  &&(u.Role== Role.Korisnik))
                  .ToPagedListAsync(searchObject, cancellationToken);
                
                 
        }

    }
}

