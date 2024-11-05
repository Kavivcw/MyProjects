import 'package:sparebess/models/params/paramable.dart';

class ParamCreatePaymentRequest implements Encodable {
  final ParamPaymentCustomerDetails customerDetails;
  final String orderId;
  final double orderAmount;
  final String orderCurrency;

  ParamCreatePaymentRequest({
    required this.customerDetails,
    required this.orderId,
    required this.orderAmount,
    required this.orderCurrency,
  });

  // factory ParamCreatePaymentRequest.fromJson(Map<String, dynamic> json) => ParamCreatePaymentRequest(
  //   customerDetails: CustomerDetails.fromJson(json["customer_details"]),
  //   orderId: json["order_id"],
  //   orderAmount: json["order_amount"],
  //   orderCurrency: json["order_currency"],
  // );

  @override
  Map<String, dynamic> toJson() => {
        "customer_details": customerDetails.toJson(),
        "order_id": orderId,
        "order_amount": orderAmount,
        "order_currency": orderCurrency,
      };
}

class ParamPaymentCustomerDetails {
  final String customerId;
  final String customerPhone;

  ParamPaymentCustomerDetails({
    required this.customerId,
    required this.customerPhone,
  });

  // factory ParamPaymentCustomerDetails.fromJson(Map<String, dynamic> json) => CustomerDetails(
  //   customerId: json["customer_id"],
  //   customerPhone: json["customer_phone"],
  // );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "customer_phone": customerPhone,
      };
}
