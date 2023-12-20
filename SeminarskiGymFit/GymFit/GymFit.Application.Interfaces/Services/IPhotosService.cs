using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application.Interfaces
{
    public interface IPhotosService : IBaseService<int, PhotoDto, PhotoUpsertDto, BaseSearchObject>
    {
        Task<List<Guid>> ProcessAsync(IEnumerable<PhotoInputModel> image);
        Task<byte[]?> GetImageAsync(Guid id, bool original);

        Task<int> getPhotoIdAsync(Guid guidId, CancellationToken cancellationToken = default);
    }
}
