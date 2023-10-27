using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class GroupReservationsService : BaseService<GroupReservations, GroupReservationDto, GroupReservationUpsertDto, BaseSearchObject, IGroupReservationsRepository>, IGroupReservationsService
    {
        public GroupReservationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<GroupReservationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
