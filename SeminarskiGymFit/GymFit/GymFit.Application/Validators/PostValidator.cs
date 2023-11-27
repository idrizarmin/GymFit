using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class PostValidator :AbstractValidator<PostUpsertDto>
    {
        public PostValidator()
        {
            RuleFor(c => c.title).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.content).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.PublishDate).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.title).NotNull().WithErrorCode(ErrorCodes.NotNull);
            //RuleFor(c => c.PhotoId).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
