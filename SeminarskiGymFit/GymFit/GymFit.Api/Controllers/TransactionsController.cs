using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Api.Controllers
{
    public class TransactionsController : BaseCrudController<TransactionDto, TransactionUpsertDto, BaseSearchObject, ITransactionsService>
    {
        public TransactionsController(ITransactionsService service, ILogger<TransactionsController> logger) : base(service, logger)
        {
        }
    }
}
