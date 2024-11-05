import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../models/data_model/m_cart_list.dart';
import '../../models/params/param_change_cart_quantity.dart';
import '../../modules/user/address/address_list/address_list_screen.dart';
import '../../shared/constant.dart';
import '../../shared/theme.dart';
import '../../views/app_bar/default_app_bar.dart';
import '../../views/app_button.dart';
import '../../views/empty_views/empty_text_button_view.dart';
import '../../views/shimmer/vertical_shimmer.dart';
import '../../views/web_image_view.dart';

const sectionSpacing = Gap(5);

const flexValues = [3, 2, 2, 2];

final cartDivider = Divider(
  color: appthemecolor1.withOpacity(0.5),
  thickness: 0.5,
  height: 1,
);

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final cartData = CartController.to;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 15);
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Cart',
      ),
      body: SafeArea(
        child: GetX<CartController>(
            initState: (_) => CartController.to.scCartList(
                  showLoading: true,
                  interaction: true,
                ),
            builder: (context) {
              final state = cartData.loadingState.value;
              if (state.isEmpty) {
                return EmptyTextAndButtonView(
                  text: 'Your Cart list is empty. Please go to shopping',
                  buttonTitle: 'Go to Shopping',
                  onPressed: () => cartData.backToShopping(),
                );
              } else {
                return Column(
                  children: [
                    Obx(
                      () {
                        return cartData.topLoaderState.value.isLoading
                            ? LinearProgressIndicator(
                                color: appthemecolor1,
                                backgroundColor: appthemecolor1.withOpacity(0.2),
                                minHeight: 5,
                              )
                            : const SizedBox(
                                height: 5,
                              );
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: horizontalPadding,
                        child: CartListAdapterView(),
                      ),
                    ),
                    const Gap(24),
                    Padding(
                      padding: horizontalPadding,
                      child: CartTotalView(),
                    ),
                    const Gap(15),
                  ],
                );
              }
            }),
      ),
    );
  }
}

class CartTotalView extends StatelessWidget {
  CartTotalView({super.key});

  final CartController cartData = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          'Cart Total Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const Gap(16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Colors.black.withOpacity(0.1))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Item(s) Subtotal'),
                const Gap(8),
                cartDivider,
                const Gap(10),
                Row(
                  children: [
                    Text('Subtotal (${cartData.arrCart.length} Item) :'),
                    Spacer(),
                    Obx(() => Text(priced(cartData.subTotal))),
                  ],
                ),
                const Gap(14),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: AppButton(
                          title: 'Proceed to Checkout',
                          fontSize: 15,
                          onPressed: () {
                            if (cartData.topLoaderState.value.isLoading ||
                                !cartData.loadingState.value.isSuccess ||
                                cartData.arrCart.isEmpty) {
                              return;
                            }
                            Get.to(
                              () => AddressListScreen(forPurchase: true),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CartListAdapterView extends StatelessWidget {
  CartListAdapterView({super.key});

  final cartData = CartController.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15),
        const Text(
          'Shopping Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Gap(15),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.1),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: hSpace),
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderTitle(
                        title: 'Products',
                        flex: flexValues[0],
                        alignment: Alignment.centerLeft,
                      ),
                      sectionSpacing,
                      HeaderTitle(
                        title: 'Unit Price',
                        flex: flexValues[1],
                      ),
                      sectionSpacing,
                      HeaderTitle(
                        title: 'Quantity',
                        flex: flexValues[2],
                      ),
                      sectionSpacing,
                      HeaderTitle(
                        title: 'Subtotal',
                        flex: flexValues[3],
                      ),
                    ],
                  ),
                  // const Gap(6),
                  cartDivider,
                  if (cartData.loadingState.value.isLoading)
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: VerticalListShimmer(
                          gap: 5,
                          size: 70,
                          borderRadius: 0,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            children: cartData.arrCart
                                .map((element) => CartItemView(data: element))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  const Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: () => cartData.backToShopping(),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 15,
                                color: Colors.black,
                              ),

                              Text(
                                'Continue Shopping',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),

                      OutlinedButton(
                          onPressed: () async {
                            await cartData.deleteCart(interaction: false);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Text(
                                'Clear cart',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                ),
                              ),
                              Gap(5),
                              Icon(
                                Icons.close,
                                size: 15,
                                color: Colors.black,
                              ),
                            ],
                          )),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(5),
                      //   ),
                      //   child: TextButton(
                      //     onPressed: () {},
                      //     child: Row(
                      //       children: [
                      //         Text('Clear Cart'),
                      //         const Gap(10),
                      //         Icon(Icons.close),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const Gap(15),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CartTextWithIconButton extends StatelessWidget {
  const CartTextWithIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle(
      {super.key,
      required this.title,
      this.flex = 1,
      this.alignment = Alignment.center});

  final String title;
  final int flex;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FittedBox(
        fit: BoxFit.none,
        alignment: alignment,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    );
  }
}

class CartItemView extends StatelessWidget {
  CartItemView({super.key, required this.data});

  final MCartItem data;
  final deleteState = RxStatus.success().obs;
  final controller = CartController.to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: flexValues[0],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset('name', )
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 2,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child:
                              WebImageView(data.images.firstOrNull?.imageUrl),
                        ),
                      ),
                    ),
                    const Gap(5),
                    Flexible(
                      flex: 2,
                      child: Text(
                        data.productName,
                        style: TextStyle(fontSize: 13),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              sectionSpacing,
              Expanded(
                flex: flexValues[1],
                child: Text(
                  priced(data.price),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: green, fontSize: 13),
                ),
              ),
              sectionSpacing,
              Expanded(
                flex: flexValues[2],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.scUpdateQuantity(data, ECartOperation.minus);
                        // });
                      },
                      child: const Icon(
                        Icons.remove_circle_outline,
                        size: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Obx(
                        () => Text(
                          data.cartCount.value.toString(),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.scUpdateQuantity(data, ECartOperation.plus);
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 18,
                      ),
                    ),
                    // IconButton(
                    //     padding: EdgeInsets.zero,
                    //     constraints: BoxConstraints(),
                    //     iconSize: 20,
                    //
                    //     onPressed: () {
                    //       data.updateCartCount(data.cartCount.value + 1);
                    //     },
                    //     icon: ),
                  ],
                ),
              ),
              sectionSpacing,
              Expanded(
                flex: flexValues[3],
                child: Column(
                  children: [
                    Obx(
                      () => Text(
                        priced(data.subTotal),
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 13),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        deleteState.value = RxStatus.loading();
                        await controller.deleteCart(
                          id: data.id,
                        );
                      },
                      child: Obx(() {
                        if (deleteState.value.isLoading) {
                          return SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: appthemecolor1,
                            ),
                          );
                        } else {
                          return Icon(
                            Icons.delete_forever_outlined,
                            color: appthemecolor1,
                            size: 20,
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        cartDivider,
      ],
    );
  }
}
