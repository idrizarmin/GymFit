namespace GymFit.Core
{
    public class TransactionUpsertDto : BaseUpsertDto
    {
        public string PayPalTransactionId { get; set; }
        public decimal Amount { get; set; }
        public TransactionStatus Status { get; set; }
        public DateTime TransactionDate { get; set; }


        public int userPackageId { get; set; }
    }
}
