using GymFit.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Application.Mapping
{
    public class TransactionProfile : BaseProfile
    {
        public TransactionProfile() {
            CreateMap<TransactionDto, Transactions>().ReverseMap();

            CreateMap<TransactionUpsertDto, Transactions>();

        }
    }
}
