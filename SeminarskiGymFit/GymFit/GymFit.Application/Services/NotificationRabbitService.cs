using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure;

namespace GymFit.Application
{
    public class NotificationRabbitService : BaseService<NotificationRabbit, NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject, INotificationRabbitRepository>, INotificationRabbitService
    {
        public NotificationRabbitService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationRabbitUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}