using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;

namespace GymFit.Application
{
    public class NotificationsService : BaseService<Notification, NotificationDto, NotificationUpsertDto, NotificationsSearchObject, INotificationsRepository>, INotificationsService
    {
        public NotificationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
