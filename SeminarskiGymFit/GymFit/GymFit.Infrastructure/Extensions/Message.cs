
using GymFit.Core.Enums;

namespace GymFit.Infrastructure
{
    public class Message
    {
        public virtual ExceptionCodeEnum Status { get; set; }
        public virtual string Info { get; set; }
        public virtual object Data { get; set; }
        public virtual bool IsValid { get; set; }

        public Message()
        {
        }

        public Message(bool isValid, string info, ExceptionCodeEnum status, object data = null)
        {
            IsValid = isValid;
            Status = status;
            Info = info;
            Data = data;
        }
    }
}
