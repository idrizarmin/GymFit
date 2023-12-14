using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class PackageValidator : AbstractValidator<PackageUpsertDto>
    {
        public PackageValidator() {
            RuleFor(c => c.name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.price).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.description).NotNull().WithErrorCode(ErrorCodes.NotEmpty);


        }
    }
}
