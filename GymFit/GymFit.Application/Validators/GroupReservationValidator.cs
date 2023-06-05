using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class GroupReservationValidator : AbstractValidator<GroupReservationUpsertDto>
    {
        public GroupReservationValidator()
        {
            RuleFor(c => c.ReservationId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Arrived).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ConfirmationDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
