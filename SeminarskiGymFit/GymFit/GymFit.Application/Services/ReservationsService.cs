using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Core.Enums;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Application
{
    public class ReservationsService : BaseService<Reservation, ReservationDto, ReservationUpsertDto, ReservationSearchObject, IReservationsRepository>, IReservationsService
    {
        public ReservationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<ReservationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
        public async Task<List<ReservationDto>> GetAllFilteredAsync(ReservationSearchObject searchObject, CancellationToken cancellationToken)
        {
            var reservations = await CurrentRepository.GetAllFiltered(searchObject, cancellationToken);

            return Mapper.Map<List<ReservationDto>>(reservations);
        }
        public async Task<List<int>> GetCountByMonthAsync(ReservationBarChartSearchObject searchObject, CancellationToken cancellationToken = default) {

            return await CurrentRepository.GetCountByMonth(searchObject,cancellationToken);
        }

        public async Task<int> getCountCurrentMonthReservations(CancellationToken cancellationToken)
        {

            return CurrentRepository.getCountCurrentMonthReservations(cancellationToken);
        }



        public async Task<Message> SetReservationToConfirmedOrCancelled(int id, CancellationToken cancellationToken)
        {
            var reservation = await CurrentRepository.GetByIdAsync(id);
            try
            {
                bool changed = false;
                if (reservation.Status == ReservationStatus.Created)
                {
                    reservation.Status = ReservationStatus.Confirmed;
                    changed = true;
                }

                if (reservation.Status == ReservationStatus.Confirmed && changed == false)
                    reservation.Status = ReservationStatus.Cancelled;

                 CurrentRepository.Update(reservation);
                await    UnitOfWork  .SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return new Message
                {
                    IsValid = false,
                    Info = ex.Message,
                    Status = ExceptionCodeEnum.BadRequest
                };
            }
            return new Message
            {
                IsValid = true,
                Status = ExceptionCodeEnum.Success
            };
        }
       
    }
}
