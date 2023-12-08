using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;
using GymFit.Infrastructure.Interfaces.SearchObjects;
using Microsoft.EntityFrameworkCore;

namespace GymFit.Application
{
    public class NotificationsService : BaseService<Notification, NotificationDto, NotificationUpsertDto, NotificationsSearchObject, INotificationsRepository>, INotificationsService
    {
        public NotificationsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<NotificationUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }

        public async Task<List<NotificationDto>> GetAllNotificationsAsync(NotificationsSearchObject searchObject, CancellationToken cancellationToken = default)
        {
            var notifications = await CurrentRepository.GetAllNotifications(searchObject, cancellationToken);

            return Mapper.Map<List<NotificationDto>>(notifications);
        }

        #region Hangfire
        public async Task CreateBirthdayNotifications()
        {
         var users =  await UnitOfWork.UserRepository.GetAllUsers();

            var today = DateTime.Now;
            var hours = new TimeSpan(12, 00, 00);
            today = today.Date + hours;

            {
                try
                {
                    foreach (var client in users)
                    {
                        if (client.DateOfBirth.Month == DateTime.Now.Month && client.DateOfBirth.Day == DateTime.Now.Day)
                        {
                            var notification = new Notification();
                            notification.Content = $"Sretan rođendan želi Vam gymFit";
                            notification.SendOnDate = today;
                            notification.SendOnDate= today;
                            notification.CreatedAt = today;
                            notification.UserId = client.Id;
                            notification.Read = false;


                            await CurrentRepository .AddAsync(notification);
                        }
                    }
                    await UnitOfWork.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }


            }
        }

        public async Task CreateExpiringBundleNotificationsIn3Days()
        {
            var users = await UnitOfWork.UserRepository.GetAllUsers();

            var today = DateTime.Now;
            var hours = new TimeSpan(09, 00, 00);
            today = today.Date + hours;

                try
                {
                    foreach (var client in users)
                    {
                         
                        var userPackage = await UnitOfWork.UserPackageRepository.GetUserPackage(client.Id);

                        

                        if (userPackage != null)
                        {

                            var timeSpan = (Convert.ToDateTime(userPackage.ExpirationDate) - DateTime.Now).TotalDays;
                            if (timeSpan >= 3 && timeSpan < 4)
                            {
                                var notification = new Notification();
                                notification.Content = $"Vaša članarina ističe za 3 dana!!!";
                                notification.SendOnDate = today;
                                notification.SendOnDate = today;
                                notification.CreatedAt = today;
                                notification.UserId = client.Id;
                                notification.Read = false;

                                await CurrentRepository.AddAsync(notification);
                            }
                        }
                    }

                    await UnitOfWork.SaveChangesAsync();
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
        }

        public async Task CreateExpiringBundleNotificationsToday()
        {
            var users = await UnitOfWork.UserRepository.GetAllUsers();

            var today = DateTime.Now;
            var hours = new TimeSpan(09, 00, 00);
            today = today.Date + hours;

            try
            {
                    foreach (var client in users)
                    {

                    var userPackage = await UnitOfWork.UserPackageRepository.GetUserPackage(client.Id);

                    if (userPackage != null)
                        {

                            var timeSpan = (Convert.ToDateTime(userPackage.ExpirationDate) - DateTime.Now).TotalDays;
                            if (timeSpan <= 1 && timeSpan > 0)
                            {
                            var notification = new Notification();
                            notification.Content = $"Vaša članarina ističe danas!!!";
                            notification.SendOnDate = today;
                            notification.SendOnDate = today;
                            notification.CreatedAt = today;
                            notification.UserId = client.Id;
                            notification.Read = false;

                            await CurrentRepository.AddAsync(notification);
                        }
                        }
                    }

                await UnitOfWork.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }


        }

       

        #endregion
    }
}
