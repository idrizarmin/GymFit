using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Infrastructure
{
    public class PhotosRepository : BaseRepository<Photo, int, BaseSearchObject>, IPhotosRepository
    {
        public PhotosRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
