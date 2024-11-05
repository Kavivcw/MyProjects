import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sparebess/shared/constant.dart';

import 'm_order_detail.dart';

enum EOrderStatus {
  //temp other order status
  cancelled,
  pending;

  String get detailText {
    switch (this) {
      case EOrderStatus.cancelled:
        return 'Order Cancelled';
      case EOrderStatus.pending:
        return 'Delivery on process';
    }
  }
}

class MOrderListResponse {
  final List<MOrderItem> data;

  MOrderListResponse.named({
    required this.data,
  });

  factory MOrderListResponse(Map<String, dynamic> json) =>
      MOrderListResponse.named(
        data: List<MOrderItem>.from(
            json["data"].map((x) => MOrderItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MOrderItem {
  final MOrderBillingAddress billingAddress;
  final MOrderShippingAddress shippingAddress;
  final String id;
  final String orderNumber;
  final String paymentType;
  final String transectionId;
  final String customerId;
  final String userId;
  final String orderInvno;
  final String totalWeight;
  final int totalProducts;
  final String orderTotalCgst;
  final String orderTotalSgst;
  final String orderTotalIgst;
  final String orderTotalProductPrice;
  final String orderShippingFee;
  final double orderTotalAmount;
  final String userName;
  final DateTime? customUpdateTime;
  final EOrderStatus status;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime date;
  final int v;
  final String? totalItems;

  final detail = Rxn<MOrderDetailResponse>(null);

  MOrderItem({
    required this.billingAddress,
    required this.shippingAddress,
    required this.id,
    required this.orderNumber,
    required this.paymentType,
    required this.transectionId,
    required this.customerId,
    required this.userId,
    required this.orderInvno,
    required this.totalWeight,
    required this.totalProducts,
    required this.orderTotalCgst,
    required this.orderTotalSgst,
    required this.orderTotalIgst,
    required this.orderTotalProductPrice,
    required this.orderShippingFee,
    required this.orderTotalAmount,
    required this.userName,
    required this.customUpdateTime,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.v,
    required this.totalItems,
  });

  factory MOrderItem.fromJson(Map<String, dynamic> json) => MOrderItem(
        billingAddress: MOrderBillingAddress.fromJson(json["billing_address"]),
        shippingAddress:
            MOrderShippingAddress.fromJson(json["shipping_address"]),
        id: json["_id"],
        orderNumber: json["orderNumber"],
        paymentType: json["paymentType"],
        transectionId: json["transectionId"],
        customerId: json["customerId"],
        userId: json["user_id"],
        orderInvno: json["order_invno"],
        totalWeight: json["total_weight"],
        totalProducts: int.parse(json["total_products"].toString()),
        orderTotalCgst: json["order_total_cgst"],
        orderTotalSgst: json["order_total_sgst"],
        orderTotalIgst: json["order_total_igst"],
        orderTotalProductPrice: json["order_total_product_price"],
        orderShippingFee: json["order_shipping_fee"],
        orderTotalAmount: double.parse(json["order_total_amount"].toString()),
        userName: json["user_name"],
        customUpdateTime: DateFormat(DateFormats.defaultFormat)
            .tryParseLoose(json["customUpdateTime"], true)
            ?.toLocal(),
        status: EOrderStatus.values
            .firstWhere((element) => element.name == json["status"]),
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        date: DateFormat(DateFormats.defaultFormat)
            .parseLoose(json["date"], true)
            .toLocal(),
        v: json["__v"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "billing_address": billingAddress.toJson(),
        "shipping_address": shippingAddress.toJson(),
        "_id": id,
        "orderNumber": orderNumber,
        "paymentType": paymentType,
        "transectionId": transectionId,
        "customerId": customerId,
        "user_id": userId,
        "order_invno": orderInvno,
        "total_weight": totalWeight,
        "total_products": totalProducts,
        "order_total_cgst": orderTotalCgst,
        "order_total_sgst": orderTotalSgst,
        "order_total_igst": orderTotalIgst,
        "order_total_product_price": orderTotalProductPrice,
        "order_shipping_fee": orderShippingFee,
        "order_total_amount": orderTotalAmount,
        "user_name": userName,
        "customUpdateTime": customUpdateTime,
        "status": status,
        "is_deleted": isDeleted,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "date": date,
        "__v": v,
        "total_items": totalItems,
      };
}

class MOrderBillingAddress {
  final String? bCountry;
  final String? bFname;
  final String? bLname;
  final String? bNumber;
  final String? bPincode;
  final String? bAddress;
  final String? bAddress2;
  final String? bCity;
  final String? bState;

  MOrderBillingAddress({
    required this.bCountry,
    required this.bFname,
    required this.bLname,
    required this.bNumber,
    required this.bPincode,
    required this.bAddress,
    required this.bAddress2,
    required this.bCity,
    required this.bState,
  });

  factory MOrderBillingAddress.fromJson(Map<String, dynamic> json) =>
      MOrderBillingAddress(
        bCountry: json["b_country"],
        bFname: json["b_fname"],
        bLname: json["b_lname"],
        bNumber: json["b_number"],
        bPincode: json["b_pincode"],
        bAddress: json["b_address"],
        bAddress2: json["b_address2"],
        bCity: json["b_city"],
        bState: json["b_state"],
      );

  Map<String, dynamic> toJson() => {
        "b_country": bCountry,
        "b_fname": bFname,
        "b_lname": bLname,
        "b_number": bNumber,
        "b_pincode": bPincode,
        "b_address": bAddress,
        "b_address2": bAddress2,
        "b_city": bCity,
        "b_state": bState,
      };
}

class MOrderShippingAddress {
  final String? sCountry;
  final String? sFname;
  final String? sLname;
  final String? sNumber;
  final String? sPincode;
  final String? sAddress;
  final String? sAddress2;
  final String? sCity;
  final String? sState;

  MOrderShippingAddress({
    required this.sCountry,
    required this.sFname,
    required this.sLname,
    required this.sNumber,
    required this.sPincode,
    required this.sAddress,
    required this.sAddress2,
    required this.sCity,
    required this.sState,
  });

  factory MOrderShippingAddress.fromJson(Map<String, dynamic> json) =>
      MOrderShippingAddress(
        sCountry: json["s_country"],
        sFname: json["s_fname"],
        sLname: json["s_lname"],
        sNumber: json["s_number"],
        sPincode: json["s_pincode"],
        sAddress: json["s_address"],
        sAddress2: json["s_address2"],
        sCity: json["s_city"],
        sState: json["s_state"],
      );

  Map<String, dynamic> toJson() => {
        "s_country": sCountry,
        "s_fname": sFname,
        "s_lname": sLname,
        "s_number": sNumber,
        "s_pincode": sPincode,
        "s_address": sAddress,
        "s_address2": sAddress2,
        "s_city": sCity,
        "s_state": sState,
      };
}
