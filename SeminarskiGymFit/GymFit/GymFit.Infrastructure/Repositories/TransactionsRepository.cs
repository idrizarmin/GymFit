using GymFit.Core;
using GymFit.Infrastructure.Interfaces;


namespace GymFit.Infrastructure.Repositories
{
    public class TransactionsRepository : BaseRepository<Transactions, int, BaseSearchObject>, ITransactionRepository
    {
        public TransactionsRepository(DatabaseContext databaseContext) : base(databaseContext)
        {
        }
    }
}
