using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class ArrivalValidator : AbstractValidator<ArrivalUpsertDto>
    {
        public ArrivalValidator() 
        {
            RuleFor(c => c.DepartureTime).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.ReservationId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.GymId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserPackageId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
