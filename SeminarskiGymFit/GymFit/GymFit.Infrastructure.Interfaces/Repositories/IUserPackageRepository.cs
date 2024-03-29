﻿using GymFit.Core;

namespace GymFit.Infrastructure.Interfaces
{
    public interface IUserPackageRepository : IBaseRepository<UserPackage, int, UserPackageSearchObject>
    {
        Task<UserPackage> GetUserPackage(int id,CancellationToken cancellationToken = default);
        Task<List<UserPackage>> GetAllUserPackages(CancellationToken cancellationToken = default);
        Task<List<int>> GetCountByMonth(BarChartSearchObject searchObject, CancellationToken cancellationToken = default);
        Task<PagedList<UserPackage>> GetPagedAll(UserPackageSearchObject searchObject, CancellationToken cancellationToken = default);

    }
}
