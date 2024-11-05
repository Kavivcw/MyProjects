import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/models/data_model/m_wislist.dart';
import 'package:sparebess/models/params/param_add_wishlist.dart';

import '../request.dart';

abstract class WishListRequest {
  static Request<MDefault> toggle(ParamAddWishList param) {
    return Request(
      MDefault.new,
      endPoint: 'user_wishList',
      path: Path.user,
      method: Method.post,
      param: param,
    );
  }

  static Request<MWishListResponse> list() {
    return Request(
      MWishListResponse.new,
      endPoint: 'user_wishList',
      path: Path.user,
      method: Method.get,
    );
  }
}
