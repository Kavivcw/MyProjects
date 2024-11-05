import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/models/data_model/m_product.dart';
import 'package:sparebess/models/params/param_add_cart.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/modules/home/home_screen.dart';
import 'package:sparebess/modules/home/vm_home.dart';
import 'package:sparebess/modules/product/product_detail/product_detail_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_button.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/shimmer/vertical_shimmer.dart';
import 'package:sparebess/views/web_image_view.dart';
import 'package:sparebess/views/wishlist_button.dart';

class HomeProductGridView extends StatelessWidget {
  const HomeProductGridView({
    super.key,
    this.sectionTitle,
    required this.state,
    // required this.products,
    required this.pagingController,
    this.shrinkWrap = false,
    this.physics,
    this.isExpanded = false,
    this.isCategoryPage = false,
  });

  final bool isCategoryPage;
  final LoadingState state;

  // final List<MProduct> products;
  final String? sectionTitle;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isExpanded;
  final PagingController<int, MProduct> pagingController;

  @override
  Widget build(BuildContext context) {
    return RxStatusView2(
      state: state,
      loader: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sectionTitle != null)
              HomeSectionTitleView(title: sectionTitle!),
            Center(
              child: CircularProgressIndicator(color: appthemecolor1),
            ),
          ],
        ),
      ),
      emptyView: (isCategoryPage)
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Products not available'),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppButton(
                      title: 'Reset filter',
                      fontSize: 14,
                      height: 35,
                      onPressed: () {
                        final category = Get.find<VMCategory>();
                        category.resetAllFilters();
                        category.getProducts();
                      },
                    ),
                  ],
                ),
              ],
            ))
          : null,
      builder: () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (sectionTitle != null) HomeSectionTitleView(title: sectionTitle!),
          OptionalExpanded(
            isExpanded: isExpanded,
            child: PagedGridView(
              pagingController: pagingController,
              shrinkWrap: shrinkWrap,
              physics: physics,
              padding: const EdgeInsets.symmetric(
                horizontal: hSpace,
                vertical: 2,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.66,
              ),
              builderDelegate: PagedChildBuilderDelegate<MProduct>(
                newPageProgressIndicatorBuilder: (con) {
                  return const VerticalListShimmer(
                    gap: 0,
                    borderRadius: 0,
                  );
                },
                itemBuilder: (context, item, index) {
                  return ProductItemView(data: item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItemView extends StatelessWidget {
  ProductItemView({super.key, required this.data});

  final MProduct data;
  final loadingState = LoadingState(initialState: RxStatus.success());
  final buttonState = LoadingState(initialState: RxStatus.success());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        Get.to(() => ProductDetailScreen(id: data.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  WebImageView(
                    data.images.firstOrNull?.imageUrl,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: WishListButton(
                      state: loadingState,
                      productId: data.id,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    data.productName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Text(
                        '0',
                        style: TextStyle(fontSize: 14),
                      ),
                      Gap(5),
                      RatingBar.builder(
                        initialRating: 1,
                        allowHalfRating: true,
                        itemCount: 1,
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
                      Text(
                        ' (0 ratings)',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      Text(
                        "₹ ${data.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 12,
                          color: appGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "₹ "+data.mrp.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 12,
                          color: textDecColor,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: textDecColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(8),
                  Obx(() {
                    return AppButton(
                      title: (CartController.to.cartIDs[data.id] ?? false)
                          ? 'Go to Cart'
                          : 'Add to Cart',
                      fontSize: 13,
                      height: 35,
                      state: buttonState,
                      onPressed: () {
                        if (CartController.to.cartIDs[data.id] ?? false) {
                          CartController.to.goToCart();
                        } else {
                          final param = ParamAddCart(
                              cartQuantity: 1,
                              cartPrice: data.price,
                              cartProductProductId: data.id);
                          Get.find<VMHome>().scAddToCart(param, buttonState);
                        }
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
