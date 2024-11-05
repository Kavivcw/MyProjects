import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:sparebess/controller/payment_controller.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/models/data_model/cart_id_list.dart';
import 'package:sparebess/models/data_model/m_cart_list.dart';
import 'package:sparebess/models/data_model/m_order_detail.dart';
import 'package:sparebess/models/data_model/m_order_list.dart';
import 'package:sparebess/models/data_model/m_shipping_fee_response.dart';
import 'package:sparebess/models/params/param_add_cart.dart';
import 'package:sparebess/models/params/param_change_cart_quantity.dart';
import 'package:sparebess/models/params/param_create_order.dart';
import 'package:sparebess/models/params/param_create_payment_request.dart';
import 'package:sparebess/models/response_model/m_add_cart.dart';
import 'package:sparebess/models/response_model/m_cash_free_create_payment_request_response.dart';

import '../request.dart';

abstract class OrderRequest {
  static Request<MAddCartResponse> addToCart(ParamAddCart param) {
    return Request(
      MAddCartResponse.new,
      endPoint: 'cart_add',
      path: Path.cart,
      method: Method.post,
      param: param,
    );
  }

  static Request<MCartListResponse> cartList() {
    return Request(
      MCartListResponse.new,
      endPoint: 'cart_getbyid',
      method: Method.get,
      path: Path.cart,
    );
  }

  static Request<MDefault> changeCartQuantity(ParamChangeCartQuantity param) {
    return Request(
      MDefault.new,
      endPoint: 'cart_qauntity',
      method: Method.put,
      path: Path.cart,
      param: param,
    );
  }

  static Request<MCartIdListResponse> cartIDList() {
    return Request(
      MCartIdListResponse.new,
      endPoint: 'cart_exists',
      method: Method.get,
      path: Path.cart,
    );
  }

  static Request<MDefault> deleteCart({String? id}) {
    return Request(
      MDefault.new,
      endPoint: (id == null) ? 'delete_cart' : 'delete_cart_id/$id',
      method: Method.delete,
      path: Path.cart,
    );
  }

  static Request<MDefault> postOrder(ParamPostOrder param) {
    return Request(
      MDefault.new,
      endPoint: 'Order_post',
      method: Method.post,
      path: 'Order',
      param: param,
    );
  }

  static Request<MOrderListResponse> orderList() {
    return Request(
      MOrderListResponse.new,
      endPoint: 'ordertable',
      method: Method.get,
      path: Path.order,
    );
  }

  static Request<MOrderDetailResponse> orderItemDetail(String orderID) {
    return Request(
      MOrderDetailResponse.new,
      endPoint: 'orderitemstable',
      method: Method.get,
      path: 'Order',
      param: {'orderId': orderID},
    );
  }

  static Request<MDefault> cancelOrder(String orderID) {
    return Request(
      MDefault.new,
      endPoint: 'cancelorder',
      method: Method.post,
      path: 'Order',
      param: {
        'id': orderID,
        'update': 'cancelled',
      },
    );
  }

  static Request<MShippingFeeResponse> shippingFee() {
    return Request(
      MShippingFeeResponse.new,
      endPoint: 'getinitialshipping',
      method: Method.get,
      path: 'cms',
    );
  }

  static Request<MCashFreeCreatePaymentRequestResponse> paymentRequest(
      ParamCreatePaymentRequest param) {
    final request = Request(
      MCashFreeCreatePaymentRequestResponse.new,
      method: Method.post,
      baseURL: PaymentController.to.environment == CFEnvironment.PRODUCTION
          ? 'https://api.cashfree.com'
          : 'https://sandbox.cashfree.com',
      path: 'pg',
      endPoint: 'orders',
      param: param,
    );
    request.headers.addAll(
      {
        'x-api-version': '2023-08-01',
        'x-client-id':
        'TEST1019949234229486abd5ce8b2e7429499101', //temp sandbox
            //'691476129fedad4081717a5c2c674196', //temp live
        'x-client-secret':
            'cfsk_ma_test_b6de5d068a94de921ce7813972529a53_70ac2958', //temp sandbox
            //'cfsk_ma_prod_a338ec7d49f4426f3e28e2dbb9e02dee_ea82f647', //temp live
      },
    );
    request.skipAuth();
    return request;
  }


  static Request<MCashFreeCreatePaymentRequestResponse> createorder(
      ParamCreatePaymentRequest param) {
    final request = Request(
      MCashFreeCreatePaymentRequestResponse.new,
      method: Method.post,
      baseURL: PaymentController.to.environment == CFEnvironment.PRODUCTION
          ? 'https://api.cashfree.com'
          : 'https://sandbox.cashfree.com',
      path: 'pg',
      endPoint: 'orders',
      param: param,
    );
    request.headers.addAll(
      {
        'x-api-version': '2023-08-01',
        'x-client-id':
        'TEST1019949234229486abd5ce8b2e7429499101', //temp sandbox
        //'691476129fedad4081717a5c2c674196', //temp live
        'x-client-secret':
        'cfsk_ma_test_b6de5d068a94de921ce7813972529a53_70ac2958', //temp sandbox
        //'cfsk_ma_prod_a338ec7d49f4426f3e28e2dbb9e02dee_ea82f647', //temp live
      },
    );
    request.skipAuth();
    return request;
  }
}




