using AutoMapper;
using FluentValidation;
using GymFit.Application.Interfaces;
using GymFit.Core;
using GymFit.Infrastructure;
using GymFit.Infrastructure.Interfaces;

namespace GymFit.Application
{
    public class PostService : BaseService<Post, PostDto, PostUpsertDto, BaseSearchObject, IPostRepository>, IPostService
    {
        public PostService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<PostUpsertDto> validator) : base(mapper, unitOfWork, validator)
        {
        }
    }
}
