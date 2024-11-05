import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/controller/address_controller.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/controller/payment_controller.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/models/params/param_create_order.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/payment_status_view.dart';

import '../../../manager/network_manager/requests/order_request.dart';

final class VMPayment extends GetxController {

  final paymentType = Rxn<VMPaymentTypeItem>(null);
  final arrPaymentTypes = [
    EPaymentType.cashfree,
    EPaymentType.cashOnDelivery,
  ].map((e) => VMPaymentTypeItem(type: e)).toList();
  final loadingState = LoadingState();

  Future<ParamPostOrder> constructParam(String transactionID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final shippingFeesString = prefs.getString('shippingFees');
    final shippingFees = double.tryParse(shippingFeesString ?? '0.0') ?? 0.00;

    double shipping = shippingFees;
    final cartData = CartController.to;
    final addressData = AddressController.to;
    return ParamPostOrder(
      defaultAddress: true,
      paymentType: paymentType.value!.type.param,
      products: cartData.arrCart
          .map((element) => ParamOrderProduct(
          gst: '18', // temp
          partNumber: element.partNumber,
          price: element.price,
          productId: element.cartProductProductId,
          productName: element.productName,
          quantity: element.cartCount.value,
        )).toList(),
      selectedAddress: addressData.selectedAddress.value!,
      shippingFee: shipping,
      subtotal: cartData.subTotal,
      totalWeight: cartData.totalWeight,
      transectionId: transactionID,
    );
  }

  Future<void> purchase() async {
    if (paymentType.value == null) {
      showToast('Select payment method');
      return;
    }
    switch (paymentType.value!.type) {
      case EPaymentType.cashfree:
        final controller = PaymentController.to;
        controller.webCheckout();
        break;
      case EPaymentType.cashOnDelivery:
        final param = await constructParam('-');
        scPostOrder(param);
        break;
    }
  }



  /*
  'external': {
        'wallets': ['paytm']
      }
   */
  scPostOrder(ParamPostOrder param) async {
    try {
      final response = await OrderRequest.postOrder(param)
          .load(state: loadingState, interaction: false);
      if (response.success) {
        final res = await Get.dialog(const PaymentStatusView());
        Get.popToRoot();
      } else {
        showToast(response.message);
      }
    } catch (e) {
      showToast(e);
    }
  }
}

class VMPaymentTypeItem {
  final EPaymentType type;

  VMPaymentTypeItem({required this.type});
}

enum EPaymentType {
  cashfree,
  cashOnDelivery;

  String get displayName {
    switch (this) {
      case EPaymentType.cashfree:
        return 'Cashfree Secure (UPI, Cards, Wallets, Netbanking)';
      case EPaymentType.cashOnDelivery:
        return 'Cash on Delivery (COD))';
    }
  }

  List<String> get cardImages {
    switch (this) {
      case EPaymentType.cashfree:
        return List.generate(6, (index) => 'pay${index + 1}');
      case EPaymentType.cashOnDelivery:
        return [];
    }
  }

  String get param {
    switch (this) {
      case EPaymentType.cashfree:
        return 'Online';
      case EPaymentType.cashOnDelivery:
        return 'COD';
    }
  }
}
