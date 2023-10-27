using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class CertificatesService : BaseService<Certificates, CertificateDto, CertificateUpsertDto, BaseSearchObject, ICertificatesRepository>, ICertificatesService
    {
        public CertificatesService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<CertificateUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
