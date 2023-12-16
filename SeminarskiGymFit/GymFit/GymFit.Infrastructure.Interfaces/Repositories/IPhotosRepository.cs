using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IPhotosRepository : IBaseRepository<Photo, int, BaseSearchObject>
    {
        Task<byte[]?> GetOriginalContet(Guid id);
        Task<byte[]?> GetThumbnailContent(Guid id);
    }
}
