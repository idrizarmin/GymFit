using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class ArrivalService : BaseService<Arrivals, ArrivalDto, ArrivalUpsertDto, BaseSearchObject, IArrivalsRepository>, IArrivalsService
    {
        public ArrivalService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ArrivalUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
