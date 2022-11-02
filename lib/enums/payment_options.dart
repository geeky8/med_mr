enum PaymentOptions {
  ///[PaymentOptions.ONLINE] for Online payment.
  ONLINE,

  ///[PaymentOptions.PAYLATER] for credit payments.
  PAYLATER,

  ///[PaymentOptions.PAYONDELIVERY] for credit payments.
  PAYONDELIVERY,
}

extension PaymentOptionsExtenstion on PaymentOptions {
  String toPaymentOption() {
    switch (this) {
      case PaymentOptions.ONLINE:
        return '3';
      case PaymentOptions.PAYLATER:
        return '2';
      case PaymentOptions.PAYONDELIVERY:
        return '1';
    }
  }
}