using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GymFit.Core.Enums
{
    public enum ExceptionCodeEnum
    {
        Undefined = -1,
        Success = 0,
        Error1 = 1,
        Error2 = 2,
        Error3 = 3,
        Error4 = 4,
        Error5 = 5,
        Error6 = 6,
        Error7 = 7,
        Success2 = 10,
        Success3 = 11,
        NoContent = 200,
        BadRequest = 400,
        Unauthorized = 401,
        Forbidden = 403,
        NotFound = 404,
        InternalServerError = 500,
    }
}
