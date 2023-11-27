using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure.Repositories
{
    public class PostsRepository : BaseRepository<Post, int, BaseSearchObject>, IPostRepository
    {
        public PostsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
