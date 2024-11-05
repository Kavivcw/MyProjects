import 'dart:convert';

import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/controller/auth_controller.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/models/params/param_create_payment_request.dart';
import 'package:sparebess/modules/order/payment/vm_payment.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:uuid/uuid.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.find();
  var cfPaymentGatewayService = CFPaymentGatewayService();
  CFEnvironment environment = CFEnvironment.PRODUCTION; //temp

  String customer_id='';
  String customer_name='';
  String customer_phone='';
  double order_amount=0.0;
  String order_currency='';
  String order_id='';
  String payment_session_id='';
  @override
  void onReady() {
    super.onReady();
    cfPaymentGatewayService.setCallback(verifyPayment, onError);

    // razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    // razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _paymentFailed);
    // razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _externalPaymentResponse);
  }



  Future<void> verifyPayment(String orderId) async {
    final paymentData = Get.find<VMPayment>();

    // Await the result of constructParam before passing it to scPostOrder
    final param = await paymentData.constructParam(orderId);
    paymentData.scPostOrder(param);
  }


  void onError(CFErrorResponse errorResponse, String orderId) {
    showToast(errorResponse.getMessage() ?? 'Error while making payment');
  }


  Future<CFSession> createSession() async {

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();

      final shippingFeesString = prefs.getString('shippingFees');
      final shippingFees = double.tryParse(shippingFeesString ?? '0.0') ?? 0.00;


      //double totalAmount=CartController.to.subTotal + shippingFees;
      double total =CartController.to.subTotal;
      double shipping =shippingFees;
      double totalAmount=total+shipping;
      Map<String, dynamic> requestBody = {
        "amount": totalAmount,
      };
      // Convert the JSON body to a string
      String requestBodyJson = json.encode(requestBody);

      // Convert the JSON body to a string

      //String url = "http://192.168.1.35:5000/Order/Order_create";
      String url = "https://api.sparewares.com/Order/Order_create";


      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
        },
        body: requestBodyJson,
      );


        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);

            customer_id=results['data']['customer_details']['customer_id'];
            customer_name=results['data']['customer_details']['customer_name'];
            customer_phone=results['data']['customer_details']['customer_phone'];
            order_amount=results['data']['order_amount'];
            order_currency=results['data']['order_currency'];
            order_id=results['data']['order_id'];
            payment_session_id=results['data']['payment_session_id'];


          }
        }
      final user = AuthController.to.user!;
      final String orderID = const Uuid().v4(); //temp;
      final param = ParamCreatePaymentRequest(
        customerDetails: ParamPaymentCustomerDetails(
        customerId: customer_id,
        customerPhone: customer_phone),
        orderId: order_id,
        orderAmount: order_amount,
        orderCurrency: order_currency,
      );
      //final response = await OrderRequest.createorder(param).load(interaction: false);
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderID)
          .setPaymentSessionId(payment_session_id)
          .build();
      return session;
    } catch (e) {
      rethrow;
    }
  }

  webCheckout() async {
    try {
      var session = await createSession();
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#ffffff")
          .setNavigationBarTextColor("#ffffff")
          .build();
      var cfWebCheckout = CFWebCheckoutPaymentBuilder()
          .setSession(session)
          .setTheme(theme)
          .build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      showToast(e.message);
    } catch (e) {
      showToast(e);
    }
  }
}
