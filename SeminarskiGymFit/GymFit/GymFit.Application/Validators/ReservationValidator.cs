using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class ReservationValidator : AbstractValidator<ReservationUpsertDto>
    {
        public ReservationValidator()
        {
            RuleFor(c => c.Description).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.ReservationDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c=> c.Status).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.StartDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.EndDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.GymId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
