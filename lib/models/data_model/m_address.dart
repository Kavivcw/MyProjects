import 'dart:convert';

class MAddressListResponse {
  final bool? success;
  final MAddress address;

  MAddressListResponse.named({
    required this.success,
    required this.address,
  });

  factory MAddressListResponse(Map<String, dynamic> json) =>
      MAddressListResponse.named(
        success: json["success"],
        address: MAddress.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "address": address.toJson(),
      };
}

class MAddress {
  final String id;
  final String name;
  final String customerId;
  final String number;
  final String userType;
  final List<dynamic> userWishlist;
  final bool isDeleted;
  final List<MBillingAddress> billingAddress;
  final List<MShippingAddress> shippingAddress;
  final List<dynamic> usersearch;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MAddress({
    required this.id,
    required this.name,
    required this.customerId,
    required this.number,
    required this.userType,
    required this.userWishlist,
    required this.isDeleted,
    required this.billingAddress,
    required this.shippingAddress,
    required this.usersearch,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MAddress.fromRawJson(String str) =>
      MAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MAddress.fromJson(Map<String, dynamic> json) => MAddress(
        id: json["_id"],
        name: json["name"],
        customerId: json["customerId"],
        number: json["number"],
        userType: json["user_type"],
        userWishlist: List<dynamic>.from(json["user_wishlist"].map((x) => x)),
        isDeleted: json["is_deleted"],
        billingAddress: List<MBillingAddress>.from(
            json["billing_address"].map((x) => MBillingAddress.fromJson(x))),
        shippingAddress: List<MShippingAddress>.from(
            json["shipping_address"].map((x) => MShippingAddress.fromJson(x))),
        usersearch: List<dynamic>.from(json["usersearch"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "customerId": customerId,
        "number": number,
        "user_type": userType,
        "user_wishlist": List<dynamic>.from(userWishlist.map((x) => x)),
        "is_deleted": isDeleted,
        "billing_address":
            List<dynamic>.from(billingAddress.map((x) => x.toJson())),
        "shipping_address":
            List<dynamic>.from(shippingAddress.map((x) => x.toJson())),
        "usersearch": List<dynamic>.from(usersearch.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class MBillingAddress {
  final String id;

  MBillingAddress({
    required this.id,
  });

  factory MBillingAddress.fromRawJson(String str) =>
      MBillingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MBillingAddress.fromJson(Map<String, dynamic> json) =>
      MBillingAddress(
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}

class MShippingAddress {
  final bool defaultAddress;
  final String id;
  final String? sFname;
  final String? sCountry;
  final String? sNumber;
  final String? sAddress;
  final String? sCity;
  final String? sState;
  final String? sPincode;
  final bool isDefaultData;

  MShippingAddress({
    required this.defaultAddress,
    required this.id,
    required this.sFname,
    required this.sCountry,
    required this.sNumber,
    required this.sAddress,
    required this.sCity,
    required this.sState,
    required this.sPincode,
    required this.isDefaultData,
  });

  factory MShippingAddress.fromJson(Map<String, dynamic> json) =>
      MShippingAddress(
        defaultAddress: json["defaultAddress"] ?? false,
        id: json["_id"],
        sFname: json["s_fname"],
        sCountry: json["s_country"],
        sNumber: json["s_number"],
        sAddress: json["s_address"],
        sCity: json["s_city"],
        sState: json["s_state"],
        sPincode: json["s_pincode"],
        isDefaultData: json.length <= 2,
      );

  Map<String, dynamic> toJson() => {
        "defaultAddress": defaultAddress,
        "_id": id,
        "s_fname": sFname,
        "s_country": sCountry,
        "s_number": sNumber,
        "s_address": sAddress,
        "s_city": sCity,
        "s_state": sState,
        "s_pincode": sPincode,
      };
}
