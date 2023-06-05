using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class NotificationValidator : AbstractValidator<NotificationUpsertDto>
    {
        public NotificationValidator()
        {
            RuleFor(c => c.Content).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Read).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Deleted).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);

            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
