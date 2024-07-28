class AppHelper {
  static String getPaymentMethod(String? name) {
    switch (name) {
      case "CREDIT_CARD":
        return "Credit card";
      case "WALLET":
        return "Wallet";
      case "CASH_ON_DELIVERY":
        return "Cash on delivery";
      case "CAR_POS":
        return "Car POS";
      case "POINTS":
        return "Points";
      default:
        return " - ";
    }
  }

  static String getPaymentMethodFromName(String? name) {
    switch (name) {
      case "Credit card":
        return "CREDIT_CARD";
      case "Wallet":
        return "WALLET";
      case "Cash on delivery":
        return "CASH_ON_DELIVERY";
      case "Car POS":
        return "CAR_POS";
      case "Points":
        return "POINTS";
      default:
        return " - ";
    }
  }

  static String getRefundMethod(String? name) {
    switch (name) {
      case "CREDIT_CARD":
        return "Credit card";
      case "WALLET":
        return "Wallet";
      case "POINTS":
        return "Points";
      default:
        return " - ";
    }
  }

  static String getReservationStatus(String? name) {
    switch (name) {
      case "WAITING_FOR_PAYMENT":
        return "Waiting for payment";
      case "WAITING_FOR_CONFIRMATION":
        return "Waiting for confirmation";
      case "CONFIRMED":
        return "Confirmed";
      case "PAID":
        return "Paid";
      case "CANCELLED":
        return "Cancelled";
      case "REFUNDED":
        return "Refunded";
      case "COMPLETED":
        return "Completed";
      default:
        return " - ";
    }
  }
}
