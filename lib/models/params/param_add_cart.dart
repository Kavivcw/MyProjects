import 'package:sparebess/models/params/paramable.dart';

class ParamAddCart implements Encodable {
  final String cartProductProductId;
  final double cartPrice;
  final int cartQuantity;

  ParamAddCart({
    required this.cartProductProductId,
    required this.cartPrice,
    required this.cartQuantity,
  });

  // ParamAddCart.fromJson(Map<String, dynamic> json) {
  //   cartProductProductId = json['cart_product_product_Id'];
  //   cartPrice = json['cart_price'];
  //   cartQuantity = json['cart_quantity'];
  // }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cart_product_product_Id'] = cartProductProductId;
    data['cart_price'] = cartPrice;
    data['cart_quantity'] = cartQuantity;
    return data;
  }
}
