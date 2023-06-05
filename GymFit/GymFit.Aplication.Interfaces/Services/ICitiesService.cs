using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Aplication.Interfaces
{
    public interface ICitiesService : IBaseService<int,CityDto,CityUpsertDto,BaseSearchObject>
    {
    }
}
