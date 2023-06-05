using FluentValidation.Results;
using GymFit.Core;

namespace GymFit.Application
{
    public class ValidationErrorProfile : BaseProfile
    {
        public ValidationErrorProfile()
        {
            CreateMap<ValidationFailure, ValidationError>();
        }
    }
}
