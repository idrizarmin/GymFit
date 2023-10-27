using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class CertificateValidator : AbstractValidator<CertificateUpsertDto>
    {
        public CertificateValidator()
        {
            RuleFor(c => c.Title).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.Issuer).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
        }
    }
}
