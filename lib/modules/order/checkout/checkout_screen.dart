import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/controller/address_controller.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/models/data_model/m_cart_list.dart';
import 'package:sparebess/modules/cart/cart_screen.dart';
import 'package:sparebess/modules/user/address/address_list/address_list_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:http/http.dart' as http;
import '../../../controller/auth_controller.dart';
import '../../../shared/theme.dart';
import '../../../views/app_button.dart';
import '../../../views/web_image_view.dart';
import '../payment/payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key}) {
    cartData.updateShippingFee();
  }

  final cartData = CartController.to;

  @override
  Widget build(BuildContext context) {
    const hPadding = EdgeInsets.symmetric(horizontal: 15.0);
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFFFEF2EA),
      appBar: const DefaultAppBar(title: 'Checkout'),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              child: Padding(
                padding: hPadding,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CheckoutAddressView(),
                      CheckoutOrderListView(),
                      CheckoutTotalView(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}

class CheckoutTitleView extends StatelessWidget {
  const CheckoutTitleView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class CheckoutItemView extends StatelessWidget {
  const CheckoutItemView({super.key, required this.data});

  final MCartItem data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            child: AspectRatio(
              aspectRatio: 2,
              child: WebImageView(
                data.images.firstOrNull?.imageUrl,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.productName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(5),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 14,
                          color: starcolor,
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  Row(
                    children: [
                      Text(
                        priced(data.subTotal),
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          color: appthemecolor1,
                          width: 1,
                          height: 10,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'QTY: ',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                          children: [
                            TextSpan(
                                text: data.cartCount.value.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutAddressView extends StatelessWidget {
  CheckoutAddressView({super.key});

  final address = AddressController.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CheckoutTitleView(title: 'Delivery Details'),
        AddressItemView(
          data: address.selectedAddress.value!,
          needSelectionIndicator: false,
          needAction: false,
        ),
      ],
    );
  }
}

class CheckoutOrderListView extends StatelessWidget {
  CheckoutOrderListView({super.key});

  final cartData = CartController.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        const CheckoutTitleView(title: 'Your Orders'),
        Container(
          decoration: BoxDecoration(
            color: appthemecolor1.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView.separated(
            itemCount: cartData.arrCart.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (con, index) {
              return CheckoutItemView(data: cartData.arrCart[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              // return SizedBox.shrink();
              return cartDivider;
            },
          ),
        ),
      ],
    );
  }
}

class CheckoutTotalView extends StatefulWidget {

  CheckoutTotalView( );

  @override
  State<CheckoutTotalView> createState() => _CheckoutTotalViewState();
}
class _CheckoutTotalViewState extends State<CheckoutTotalView> {
  final cartData = CartController.to;
  final addressData = Get.put(AddressController());

  late int ShippingFee;
  bool shippingfeeloader = true;

@override
void initState(){
  super.initState();
  getShippingFee();

}
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutTitleView(title: 'Order Summary'),
        shippingfeeloader? Center(

          child: CircularProgressIndicator(

            color: appthemecolor2,
          ),
        ):Container(
          margin: EdgeInsets.only(bottom: safeArea.bottom),
          padding: EdgeInsets.only(
            left: hSpace,
            right: hSpace,
          ),
          decoration: BoxDecoration(
              color: appthemecolor1.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price (${cartData.arrCart.length} Item)",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    priced(cartData.subTotal),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(fontFamily: "Amazon Ember", fontSize: 12),
                  ),
                  Text(
                    "₹ 0",
                    style: TextStyle(fontFamily: "Amazon Ember", fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Shipping Fee",
                    style: TextStyle(fontFamily: "Amazon Ember", fontSize: 12),
                  ),
                   Text(
                    "₹ $ShippingFee",
                    style: const TextStyle(fontFamily: "Amazon Ember", fontSize: 12),
                  ),

                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                    children: [
                      Obx(() {
                        return Text(
                          priced(cartData.subTotal + ShippingFee),
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        );
                      }),
                      // SizedBox(width: 10.0),
                      // Text(
                      //   "Rs. 799",
                      //   style: TextStyle(
                      //       color: Colors.grey,
                      //       fontWeight: FontWeight.bold,
                      //       fontFamily: "Amazon Ember",
                      //       fontSize: 20.0,
                      //       decoration: TextDecoration.lineThrough),
                      // ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Buy Now',
                      onPressed: () {
                        if (ShippingFee == null) {
                          cartData.updateShippingFee();
                          showToast('Failed to update shipping fee');
                          return;
                        }
                        Get.to(() => PaymentScreen());
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Future<String> getShippingFee() async {
    try{
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      //String url = "https://api.sparewares.com/delivery/get-delivery-users/"+addressData.selectedAddress.value!.sState.toString();
      //String url = "http://localhost:5000/delivery/api/app-delivery/${addressData.selectedAddress.value!.sState}/${cartData.totalWeight.toStringAsFixed(0)}";
      String url = "https://api.sparewares.com/delivery/api/app-delivery/${addressData.selectedAddress.value!.sState}/${cartData.totalWeight.toStringAsFixed(0)}";
      //  String url = "http://192.168.1.33:5000/delivery/api/app-delivery/${addressData.selectedAddress.value!.sState}/${cartData.totalWeight.toStringAsFixed(0)}";

      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
        },
      );
      setState(() {
        String mlconvertdata = utf8.decode(response.bodyBytes);
        if (mlconvertdata != "") {
          if (jsonDecode(mlconvertdata) != null ) {
            var results = jsonDecode(mlconvertdata);
            ShippingFee=results['stateCharge'];
            prefs.setString('shippingFees', ShippingFee.toString());
            shippingfeeloader=false;
          }
        }
      });
      //11_progressBarActive2 = false;
    }
    catch(err){
      print(err);
    }
    return "Successfull";
  }
}

/*
Container(
                height: 30.0,
                width: 80.0,
                decoration: BoxDecoration(
                    border: Border.all(color: appthemecolor1),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Qty",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Amazon Ember",
                      ),
                    ),
                    DropdownButton<int>(
                      value: 1,
                      onChanged: (value) {},
                      items: List.generate(10, (index) => index + 1)
                          .map((value) => DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
 */
