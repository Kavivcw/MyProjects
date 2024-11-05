import 'package:sparebess/models/params/paramable.dart';

class ParamAddWishList implements Encodable {
  final String productId;

  ParamAddWishList({required this.productId});

  @override
  Map<String, dynamic> toJson() => {
        'productId': productId,
      };
}
