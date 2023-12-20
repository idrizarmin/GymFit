using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Infrastructure
{
    public class PhotosRepository : BaseRepository<Photo, int, BaseSearchObject>, IPhotosRepository
    {
        public PhotosRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }

        public async Task<byte[]?> GetOriginalContet(Guid id)
        {
            return await DbSet.Where(i => i.GuidId == id).Select(i => i.Data).SingleOrDefaultAsync();
        }

        public async Task<byte[]?> GetThumbnailContent(Guid id)
        {
            return await DbSet.Where(i => i.GuidId == id).Select(i => i.ThumbnailContent).SingleOrDefaultAsync();
        }

        public async Task<int> getPhotoId(Guid guidId, CancellationToken cancellationToken = default)
        {
            var photo = await DbSet.Where(i=> i.GuidId == guidId).FirstOrDefaultAsync();

            return photo.Id;
            
        }
    }
}
