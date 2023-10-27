using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class PhotoValidator : AbstractValidator<PhotoUpsertDto>
    {
        public PhotoValidator()
        {
            RuleFor(p => p.Data).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
