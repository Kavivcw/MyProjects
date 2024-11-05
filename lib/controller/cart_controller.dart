import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/models/data_model/m_cart_list.dart';
import 'package:sparebess/models/data_model/m_shipping_fee_response.dart';
import 'package:sparebess/models/params/param_add_cart.dart';
import 'package:sparebess/modules/cart/cart_screen.dart';
import 'package:sparebess/shared/constant.dart';

import '../models/params/param_change_cart_quantity.dart';
import 'home_controller.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  final arrCart = <MCartItem>[].obs;
  final loadingState = LoadingState();
  final topLoaderState = RxStatus.success().obs;
  final shippingFeeData = Rxn<MShippingFee>();
  double get shippingFee {
    return shippingFeeData.value?.initialPrice ?? 0;
  }

  final cartIDs = <String, bool>{}.obs;

  int get cartCount {
    return cartIDs.length;
  }
  // final debounce = Debouncer(delay: const Duration(seconds: 1));

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    scUpdateCartCount();
  }

  updateShippingFee() async {
    try {
      final res = await OrderRequest.shippingFee().load();
      shippingFeeData.value = res.data.firstOrNull;
    } finally {}
  }

  double get subTotal {
    final total = arrCart.fold(
        0.0, (previousValue, element) => previousValue + element.subTotal);
    return total;
  }

  double get totalWeight {
    final total = arrCart.fold(
        0.0, (previousValue, element) => previousValue + element.totalWeight);
    return total;
  }

  scUpdateCartCount() async {
    try {
      final response = await OrderRequest.cartIDList().load();
      cartIDs.value = {};
      for (final element in response.data) {
        cartIDs[element] = true;
      }
    } finally {}
  }

  scAddToCart(ParamAddCart param, {bool reload = false}) async {
    topLoaderState.value = RxStatus.loading();
    try {
      await OrderRequest.addToCart(param).load(
        // state: topLoaderState,
        showErrorToast: true,
        interaction: false,
      );
    } finally {
      if (reload) {
        await scCartList();
      } else {
        scUpdateCartCount();
      }
      topLoaderState.value = RxStatus.success();
    }
  }

  deleteCart({String? id, interaction = true}) async {
    try {
      await OrderRequest.deleteCart(id: id)
          .load(showErrorToast: true, interaction: interaction);
      // if (response.success) {
      //   if (id == null) {
      //     arrCart.clear();
      //   } else {
      //     arrCart.removeWhere((element) => element.id == id);
      //   }
      // }
    } catch (e) {
      // showToast(e);
    } finally {
      scCartList();
    }
  }

  scUpdateQuantity(MCartItem item, ECartOperation operation) async {
    if (item.cartCount.value == 1 && operation == ECartOperation.minus) {
      return;
    } else if (item.cartCount.value == 10 && operation == ECartOperation.plus) {
      return;
    }
    final param = ParamChangeCartQuantity(id: item.id, operation: operation);
    topLoaderState.value = RxStatus.loading();
    try {
      await OrderRequest.changeCartQuantity(param).load(
        // state: topLoaderState,
        showErrorToast: true,
        interaction: false,
      );
    } finally {
      await scCartList();
      topLoaderState.value = RxStatus.success();
    }
  }

  backToShopping() {
    if (Get.currentRoute == '/CartScreen') {
      Get.popToRoot();
    } else {
      HomeController.to.tabIndex = 0;
    }
  }

  scCartList({bool interaction = false, bool showLoading = false}) async {
    try {
      final response = await OrderRequest.cartList().load(
        state: loadingState,
        interaction: interaction,
        showLoading: showLoading,
      );
      arrCart.value = response.products;
      loadingState.updateSuccess(arrCart.isNotEmpty);
      cartIDs.value = {};
      for (final element in response.products) {
        cartIDs[element.cartProductProductId] = true;
      }
    } catch (e) {
      arrCart.clear();
    } finally {}
  }

  goToCart() {
    if (Get.currentRoute == '/') {
      HomeController.to.tabIndex = 3;
    } else {
      Get.to(() => CartScreen());
    }
  }
}
