abstract class PaymentMethod {
  String get name;
  String get icon;
}
class PayPalPayment implements PaymentMethod {
  @override
  String get name => "PayPal";

  @override
  String get icon => "assets/paypal.png";
}

class GooglePayPayment implements PaymentMethod {
  @override
  String get name => "Google Pay";

  @override
  String get icon => "assets/googlePay.png";
}

class ApplePayPayment implements PaymentMethod {
  @override
  String get name => "Apple Pay";

  @override
  String get icon => "assets/applePay.png";
}
