namespace Backend.CustomizedExceptions
{
    public class RepeatedExeption : Exception
    {
        public RepeatedExeption() { }

        public RepeatedExeption(string message) : base(message) { }

        public RepeatedExeption(string message, Exception innerException) : base(message, innerException) { }
    }
}
