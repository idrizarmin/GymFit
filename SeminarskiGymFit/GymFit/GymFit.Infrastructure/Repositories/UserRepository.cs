using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class UserRepository : BaseRepository<User, int, BaseSearchObject>, IUserRepository
    {
        public UserRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
        public async Task<User?> GetByEmailAsync(string email, CancellationToken cancellationToken = default)
        {
            return await DbSet.AsNoTracking().FirstOrDefaultAsync(u => u.Email == email, cancellationToken);
        }
    }
}
