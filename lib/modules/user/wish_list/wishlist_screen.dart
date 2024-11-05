import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/controller/wish_list_controller.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/models/data_model/m_wislist.dart';
import 'package:sparebess/models/params/param_add_cart.dart';
import 'package:sparebess/modules/cart/cart_screen.dart';
import 'package:sparebess/modules/user/wish_list/vm_wishlist.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';

import '../../../shared/theme.dart';
import '../../../views/web_image_view.dart';

class WishListScreen extends StatelessWidget {
  WishListScreen({super.key}) {
    wishListData.scLoadWishList();
  }

  final data = VMWishList();
  final wishListData = WishListController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(
          title: 'Wishlist',
        ),
        body: SafeArea(
          child: RxStatusView1(
            state: wishListData.state,
            child: () {
              return Obx(
                () => ListView.separated(
                  itemCount: wishListData.arrData.length,
                  padding: const EdgeInsets.all(15)
                      .copyWith(bottom: safeBottomIfNeed()),
                  itemBuilder: (BuildContext context, index) {
                    final item = wishListData.arrData[index];
                    return WishListItemView(data: item);
                  },
                  separatorBuilder: (con, index) {
                    return const Gap(15);
                  },
                ),
              );
            },
          ),
        ));
  }
}

class WishListItemView extends StatelessWidget {
  WishListItemView({super.key, required this.data});

  final MWishList data;
  final controller = WishListController.to;
  final deleteState = LoadingState(initialState: RxStatus.success());
  final cartState = LoadingState(initialState: RxStatus.success());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: appthemecolor1.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ]),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: appthemecolor1),
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.red.shade50,
                ),
                child: WebImageView(data.images.firstOrNull?.imageUrl),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      Row(
                        children: [
                          Text(data.totalrating),
                          const Gap(5),
                          RatingBar.builder(
                            initialRating: 3,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            ignoreGestures: true,
                            itemPadding: const EdgeInsets.only(right: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {

                            },
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Text(
                            priced(data.price),
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          const SizedBox(width: 7.0),
                          Text(
                            priced(data.mrp),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                              decorationThickness: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return IconButton(
                  onPressed: () {
                    tryWithLoading(deleteState, () async {
                      await controller.scToggle(data.id);
                      deleteState.value = RxStatus.success();
                    });
                  },
                  icon: deleteState.value.isLoading
                      ? CircularProgressIndicator(color: appthemecolor1)
                      : const Icon(Icons.delete_forever_outlined),
                  color: appthemecolor1,
                );
              }),
            ],
          ),
          const Gap(15),
          AppButton(
            title: 'Buy Now',
            fontSize: 15,
            state: cartState,
            onPressed: () {
              tryWithLoading(cartState, () async {
                final param = ParamAddCart(
                  cartProductProductId: data.id,
                  cartPrice: data.price,
                  cartQuantity: 1,
                );
                final response = await OrderRequest.addToCart(param).load();
                CartController.to.scUpdateCartCount();
                if (response.success) {
                  Get.to(() => CartScreen());
                }
                cartState.value = RxStatus.success();
              });
            },
          ),
          const Gap(5),
        ],
      ),
    );
  }
}
