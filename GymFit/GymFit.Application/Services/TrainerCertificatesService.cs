using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class TrainerCertificatesService : BaseService<TrainerCertificate, TrainerCertificateDto, TrainerCertificateUpsertDto, BaseSearchObject, ITrainerCertificatesRepository>, ITrainerCertificatesService
    {
        public TrainerCertificatesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<TrainerCertificateUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
