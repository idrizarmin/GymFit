using GymFit.Core;
namespace GymFit.Infrastructure.Interfaces
{
    public interface ITransactionRepository : IBaseRepository<Transactions,int, BaseSearchObject>
    {
    }
}
