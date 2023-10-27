using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class GymsService : BaseService<Gym, GymDto, GymUpsertDto, BaseSearchObject, IGymRepository>, IGymsService
    {
        public GymsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<GymUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
