namespace GymFit.Common.Services
{
    public  interface IEnumsService
    {
        Task<IEnumerable<KeyValuePair<int, string>>> GetRolesAsync();
    }
}
