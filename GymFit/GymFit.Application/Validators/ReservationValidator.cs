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
            RuleFor(c => c.StartDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.EndDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Duration).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.PauseDuration).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.MaxCapacity).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.DaysOfWeek).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.isUsed).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.GymId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.TrainerId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
