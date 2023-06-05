using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface IPhotosService : IBaseService<int, PhotoDto, PhotoUpsertDto, BaseSearchObject>
    {
    }
}
