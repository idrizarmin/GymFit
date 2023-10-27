using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class ClientProgresValidator : AbstractValidator<ClientProgresUpsertDto>
    {
        public ClientProgresValidator()
        {
            RuleFor(c => c.UserId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
