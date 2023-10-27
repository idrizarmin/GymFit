using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class TrainerCertificateValidator : AbstractValidator<TrainerCertificateUpsertDto>
    {
        public TrainerCertificateValidator()
        {
            RuleFor(c => c.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Issuer).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);

            RuleFor(c => c.TrainerId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.CertificateId).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.DateOfAchievement).NotNull().WithErrorCode(ErrorCodes.NotNull);
        }
    }
}
