using FluentValidation;
using GymFit.Core;

namespace GymFit.Application
{
    public class TransactionValidator : AbstractValidator<TransactionUpsertDto>
    {

        public TransactionValidator() {
            RuleFor(c => c.TransactionDate).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.PayPalTransactionId).NotEmpty().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Status).NotNull().WithErrorCode(ErrorCodes.NotNull);
            RuleFor(c => c.Amount).NotEmpty().WithErrorCode(ErrorCodes.NotEmpty);
            RuleFor(c => c.userPackageId).NotNull().WithErrorCode(ErrorCodes.NotNull);


        }
    }
}
