using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Application.Interfaces
{
    public interface ITransactionsService : IBaseService<int,TransactionDto,TransactionUpsertDto, BaseSearchObject >
    {
        Task<string> ProcessStripePayment(TransactionDto transaction);
    }
}
