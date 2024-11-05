import 'dart:convert';

import 'package:sparebess/models/data_model/m_address.dart';
import 'package:sparebess/models/params/paramable.dart';

class ParamPostOrder implements Encodable {
  final bool defaultAddress;
  final String paymentType;
  final List<ParamOrderProduct> products;
  final MShippingAddress selectedAddress;
  final double shippingFee;
  final double subtotal;
  final double totalWeight;
  final String transectionId;

  ParamPostOrder({
    required this.defaultAddress,
    required this.paymentType,
    required this.products,
    required this.selectedAddress,
    required this.shippingFee,
    required this.subtotal,
    required this.totalWeight,
    required this.transectionId,
  });

  String toRawJson() => json.encode(toJson());

  @override
  Map<String, dynamic> toJson() => {

        "defaultAddress": defaultAddress,
        "paymentType": paymentType,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "selectedAddress": selectedAddress.toJson(),
        "shippingFee": shippingFee,
        "subtotal": subtotal,
        "total_weight": totalWeight,
        "transectionId": transectionId,
      };
}

class ParamOrderProduct {
  final String gst;
  final String partNumber;
  final double price;
  final String productId;
  final String productName;
  final int quantity;

  ParamOrderProduct({
    required this.gst,
    required this.partNumber,
    required this.price,
    required this.productId,
    required this.productName,
    required this.quantity,
  });

  factory ParamOrderProduct.fromRawJson(String str) =>
      ParamOrderProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ParamOrderProduct.fromJson(Map<String, dynamic> json) =>
      ParamOrderProduct(
        gst: json["gst"],
        partNumber: json["part_number"],
        price: json["price"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "gst": gst,
        "part_number": partNumber,
        "price": price,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
      };
}
