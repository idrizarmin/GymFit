using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class TransactionsService : BaseService<Transactions, TransactionDto, TransactionUpsertDto, BaseSearchObject, ITransactionRepository>, ITransactionsService
    {
        public TransactionsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<TransactionUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public Task<string> ProcessStripePayment(TransactionDto transaction)
        {
            throw new NotImplementedException();
        }
    }
}
