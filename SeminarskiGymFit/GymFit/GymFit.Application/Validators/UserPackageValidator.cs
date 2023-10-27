using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class UserPackageValidator : AbstractValidator<UserPackageUpsertDto>
    {
        public UserPackageValidator()
        {
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.IsPaused).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Expired).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
