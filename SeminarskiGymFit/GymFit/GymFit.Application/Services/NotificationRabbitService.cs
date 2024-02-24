using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure;
using GymFit.Core.Enums;

namespace GymFit.Application
{
    public class NotificationRabbitService : BaseService<NotificationRabbit, NotificationRabbitDto, NotificationRabbitUpsertDto, BaseSearchObject, INotificationRabbitRepository>, INotificationRabbitService
    {
        public NotificationRabbitService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationRabbitUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {

        }

        public async Task<Message> SetNotificationsAsSeenAsMessageAsync(int userId, CancellationToken cancellationToken)
        {

            var user = await UnitOfWork.UserRepository.GetByIdAsync(userId);

            var notifications = await CurrentRepository.GetAllByUserId(userId);

            {
                try
                {
                    foreach (var notification in notifications)
                    {
                        notification.IsRead = true;

                        await UnitOfWork.SaveChangesAsync();

                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
                return new Message
                {
                    Info = "Notifications seen!",
                    IsValid = true,
                    Status = ExceptionCodeEnum.Success
                };
            }
        }

        public async Task<Message> SetNotificationAsDeleted(int id, CancellationToken cancellationToken)
        {
            var notification = await CurrentRepository.GetByIdAsync(id);

            try
            {
                //Seen se koristi kako datum brisanja
                if (notification != null)
                {
                    notification.IsDeleted = true;
                    notification.IsRead = true;

                    CurrentRepository.Update(notification);
                    await UnitOfWork.SaveChangesAsync();
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return new Message
            {
                Info = "Notification set as deleted!",
                IsValid = true,
                Status = ExceptionCodeEnum.Success
            };
        }
    }
}