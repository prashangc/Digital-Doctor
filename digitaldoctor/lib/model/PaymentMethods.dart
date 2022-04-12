class PaymentMethods {
  String? imageUrl;
  String? name;

  PaymentMethods({this.imageUrl, this.name});
}

List<PaymentMethods> paymentMethods = [
  PaymentMethods(
    imageUrl: 'assets/eSewa.png',
    name: 'esewa',
  ),
  PaymentMethods(
    imageUrl: 'assets/khalti.png',
    name: 'khalti',
  ),
  PaymentMethods(
    imageUrl: 'assets/fonepay.png',
    name: 'fonepay',
  ),
];
