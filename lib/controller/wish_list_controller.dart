import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/wishlist_request.dart';
import 'package:sparebess/models/data_model/m_wislist.dart';
import 'package:sparebess/shared/constant.dart';

import '../models/params/param_add_wishlist.dart';

final class WishListController extends GetxController {
  static WishListController get to => Get.find();
  final arrData = <MWishList>[].obs;
  final wishListStatus = <String, bool>{}.obs;
  final state = LoadingState();

  bool getStatus(String id) {
    return wishListStatus[id] ?? false;
  }

  scLoadWishList() async {
    await _scLoadWishList(loadingState: state);
  }

  _scLoadWishList({LoadingState? loadingState}) async {
    // await waitSomeTime();
    try {
      final response = await WishListRequest.list().load(state: loadingState);
      arrData.value = response.productDetails;
      final dict = <String, bool>{};
      response.productId.firstOrNull?.userWishlist.forEach((element) {
        dict[element] = true;
      });
      wishListStatus.value = dict;
      state.updateSuccess(arrData.isNotEmpty);
    } catch (e) {}
  }

  Future<bool?> scToggle(String productId, {bool silentReload = true}) async {
    bool? result;
    try {
      final param = ParamAddWishList(productId: productId);
      final response = await WishListRequest.toggle(param).load();
      if (response.message == 'Removed from wishlist') {
        wishListStatus[productId] = false;
        arrData.removeWhere((element) => element.id == productId);
        state.updateSuccess(arrData.isNotEmpty);
        result = false;
      } else if (response.message == 'Added to wishlist') {
        wishListStatus[productId] = true;
        result = true;
      }
    } catch (e) {
      showToast(e);
    } finally {
      _scLoadWishList(loadingState: silentReload ? null : state);
    }
    return result;
  }
}
