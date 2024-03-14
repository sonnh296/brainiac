using Frontend.Models;

namespace Frontend.Services
{
    public interface IVnPayService
    {
        string CreatePaymentUrl(PaymentInformationModel model, HttpContext context, string urlCallBack);
        PaymentResponseModel PaymentExecute(IQueryCollection collections);
    }
}
