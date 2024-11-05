class MAddCartResponse {
  late final bool success;
  late final List<MAddCart> carts;

  MAddCartResponse(Map<String, dynamic> json) {
    success = json['success'];
    carts = List.from(json['carts']).map((e) => MAddCart.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['carts'] = carts.map((v) => v.toJson()).toList();
    return data;
  }
}

class MAddCart {
  late final String sId;
  late final String cartUserUserId;
  late final String cartProductProductId;
  late final int cartQuantity;
  late final double cartPrice;
  late final bool saveForLater;
  late final bool isDeleted;
  late final String createdAt;
  late final String updatedAt;
  late final int iV;

  MAddCart({
    required this.sId,
    required this.cartUserUserId,
    required this.cartProductProductId,
    required this.cartQuantity,
    required this.cartPrice,
    required this.saveForLater,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.iV,
  });

  MAddCart.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cartUserUserId = json['cart_user_user_Id'];
    cartProductProductId = json['cart_product_product_Id'];
    cartQuantity = int.parse(json['cart_quantity'].toString());
    cartPrice = double.parse(json['cart_price'].toString());
    saveForLater = json['save_for_later'];
    isDeleted = json['is_deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['cart_user_user_Id'] = cartUserUserId;
    data['cart_product_product_Id'] = cartProductProductId;
    data['cart_quantity'] = cartQuantity;
    data['cart_price'] = cartPrice;
    data['save_for_later'] = saveForLater;
    data['is_deleted'] = isDeleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
