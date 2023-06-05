using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class UserVaidator : AbstractValidator<UserUpsertDto>
    {
        public UserVaidator() 
        {
            RuleFor(u => u.FirstName).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.LastName).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.Email).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty)
                                 .EmailAddress().WithErrorCode(ErrorCodes.InvalidValue);

            RuleFor(u => u.Password)
                .NotEmpty()
                .NotNull()
                .MinimumLength(8)
                .Matches(@"[A-Z]+")
                .Matches(@"[a-z]+")
                .Matches(@"[0-9]+")
                .WithErrorCode(ErrorCodes.InvalidValue)
                .When(u => u.Id == null || u.Password != null);

            RuleFor(u => u.PhoneNumber).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(u => u.IsVerified).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(u => u.IsActive).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(u => u.CityId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(u => u.Gender).IsInEnum().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
