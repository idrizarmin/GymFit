using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class GymValidator : AbstractValidator<GymUpsertDto>
    {
        public GymValidator()
        {
            RuleFor(c => c.Name).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Address).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Description).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.PhoneNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);

            RuleFor(c => c.PhotoId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.CityId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
