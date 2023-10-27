using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class ClientProgresService : BaseService<ClientProgress, ClientProgresDto, ClientProgresUpsertDto, BaseSearchObject, IClientProgresRepository>, IClientProgresService
    {
        public ClientProgresService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ClientProgresUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
