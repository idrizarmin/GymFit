using FluentValidation;
using GymFit.Core;


namespace GymFit.Application
{
    public class NotificationRabbitValidator : AbstractValidator<NotificationRabbitUpsertDto>
    {
        public NotificationRabbitValidator()
        {

        }
    }
}
