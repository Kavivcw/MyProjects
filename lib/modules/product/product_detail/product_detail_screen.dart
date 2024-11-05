import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/modules/product/relatedProduct_detail/related_product_model.dart';
import 'package:sparebess/modules/product/product_detail/vm_product_detail.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/wishlist_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../views/dot_indicator.dart';
import '../../../views/web_image_view.dart';
import '../../cart/cart_screen.dart';
import '../relatedProduct_detail/relatedproduct_detail_screen.dart';


class ProductDetailScreen extends StatelessWidget {
  late final VMProductDetail data;

  ProductDetailScreen({super.key, required String id}) {
    final detail = VMProductDetail(id: id);
    data = Get.put(detail);
  }

  final wishlistState = LoadingState(initialState: RxStatus.success());
  final buyNowState = LoadingState(initialState: RxStatus.success());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: 'Product Details',
        actions: [
          Obx(() {
            final product = data.product.value;
            if (product != null) {
              return WishListButton(
                color: Colors.white,
                productId: product.id,
                state: wishlistState,
              );
            } else {
              return const SizedBox.shrink();
            }
          })
        ],
      ),


      body: SafeArea(
        child: RxStatusView1(
          state: data.state,
          loader: const DefaultLoader(),
          child: () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          /*      ElevatedButton(onPressed: (){


                }, child: Text("C V  ")),*/
                const ProductDetailView(),
                // ProductSocialShareView(),
                ProductDetailSocialMediaView(),

                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: hSpace),
                  child: Column(
                    children: [
                      Row(
                        children: EProductDetailTab.values
                            .map(
                              (e) => ProductDetailTabButton(
                                title: e.name,
                                isSelected: data.selectedTab.value == e,
                                onChange: () {
                                  data.selectedTab.value = e;
                                },
                              ),
                            )
                            .toList(),
                      ),
                      Divider(
                        height: 0,
                        thickness: 0.5,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
                const Gap(10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: hSpace),
                  child: Builder(builder: (_) {
                    switch (data.selectedTab.value) {
                      case EProductDetailTab.compatibility:
                        return ProductDescriptionView();
                      case EProductDetailTab.specification:
                        return ProductSpecificationView();
                    }
                  }),
                ),
                // RelatedProductListView(),
                const ProductRatingOverView(),
                const Gap(1),

              ],
            ),
          ),
        ),
      ),


      bottomNavigationBar: Obx(() {
        return Container(
          margin: EdgeInsets.only(bottom: defaultBottomPadding()),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: hSpace),
                  child: AppButton(
                    fontSize: 15,
                    height: 38,
                    title: 'Buy Now',
                    state: buyNowState,
                    onPressed: data.product.value != null
                        ? () {
                      data.goToCart(buyNowState);
                    }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}



class ProductDetailTabButton extends StatelessWidget {
  const ProductDetailTabButton(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onChange});

  final String title;
  final bool isSelected;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChange,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: appthemecolor1.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(1, 1))
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              )
            : const BoxDecoration(
                color: Colors.white,
              ),
        // BoxDecoration(
        //         border: Border(
        //             bottom: BorderSide(color: Colors.black.withOpacity(0.2))),
        //       ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isSelected ? appthemecolor1 : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailView extends StatefulWidget {


  const ProductDetailView({super.key} );

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {

  final VMProductDetail data = Get.find();
  final currentIndex = 0.obs;
  final CarouselSliderController _controller = CarouselSliderController();
  final cartState = LoadingState(initialState: RxStatus.success());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = data.product.value!;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  aspectRatio: 1.9,
                  disableCenter: true,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  }),
              items: product.images.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.grey.shade50,
                    child: WebImageView(e.imageUrl),
                  ),
                );
              }).toList(),
            ),
            DotIndicator(
              currentIndex: currentIndex,
              total: product.images.length,
              onTapIndex: (index) {
                _controller.animateToPage(index);
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: hSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Text(
                product.productName,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const Gap(2),
              Row(
                children: [
                  Text(product.totalrating.toStringAsFixed(1)),
                  const Gap(5),
                  RatingBar.builder(
                    initialRating: max(0.5, product.totalrating),
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    ignoreGestures: true,
                    itemPadding: const EdgeInsets.only(right: 2.0),
                    unratedColor: Colors.grey.shade400,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {

                    },
                  ),
                  Text(' (${product.ratings.length} ratings)'),
                ],
              ),
              const Gap(10),
              Text(
                priced(product.price),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const Gap(2),
              Text.rich(
                TextSpan(
                  text: 'MRP ',
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.6)),
                  children: [
                    TextSpan(
                      text: priced(product.mrp),
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text:
                          '  ${((1.0 - (product.price / product.mrp)) * 100).toStringAsFixed(0)}% OFF',
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(2),
              Text(
                'Price Inclusive of all taxes',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              const Gap(10),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        // const Gap(5),
                        IconButton(
                          onPressed: () {
                            data.cartCount.value = max(1, data.cartCount.value - 1);
                            data.isShowAddToCart.value = true;
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: appthemecolor1,
                          ),
                        ),
                        SizedBox(
                          // width: 30,
                          child: Obx(() {
                            return Text(
                              data.cartCount.value.toString(),
                              textAlign: TextAlign.center,
                            );
                          }),
                        ),
                        IconButton(
                          onPressed: () {
                            data.cartCount.value =
                                min(10, data.cartCount.value + 1);
                            data.isShowAddToCart.value = true;
                          },
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: appthemecolor1,
                          ),
                        ),
                        // const Gap(5),
                      ],
                    ),
                  ),
                  const Gap(15),
                  Obx(() {
                    return AppButton(
                      fontSize: 14,
                      height: 38,
                      title: (!data.isShowAddToCart.value && data.isInCart)
                          ? 'Go to Cart'
                          : 'Add To Cart',
                      state: cartState,
                      onPressed: () async {
                        if (!data.isShowAddToCart.value && data.isInCart) {
                          Get.to(() => CartScreen());
                        } else {
                          try {
                            await data.addToCart(cartState);
                            data.isShowAddToCart.value = false;
                          } catch (e) {
                            showToast(e);
                          }
                        }
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    // return AspectRatio(
    //   aspectRatio: 2,
    //   child: Container(
    //     color: Colors.red,
    //     child: SizedBox(
    //       height: 100,
    //       child: PageView(
    //         scrollDirection: Axis.horizontal,
    //         children: data.images.map((e) => WebImageView(e.imageUrl)).toList(),
    //       ),
    //     ),
    //   ),
    // );
  }


}


class ProductDetailSocialMediaView extends StatelessWidget {
  ProductDetailSocialMediaView({super.key});

  final VMProductDetail data = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hSpace).copyWith(top: 20),
      child: Row(
        children: [
          const Text('Share With :'),
          const Gap(10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: data.socialMedia
                .map((e) => Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              child: GestureDetector(

                onTap: () async {
                  if (await canLaunchUrlString(e.link)) {
                    await launchUrlString(e.link,
                        mode: LaunchMode.externalApplication);
                  } else {
                    showToast('Could not launch this url');
                  }
                },
                child: Image.asset(
                  'lib/images/share/${e.image}.png',
                ),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
class ProductSpecificationView extends StatelessWidget {
  ProductSpecificationView({super.key});

  final VMProductDetail data = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (con, index) {
        final item = data.specifications[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: textfontColor.withOpacity(0.8),
                ),
              ),
            ),
            Expanded(
              child: Text(
                item.desc,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (con, index) {
        return const Gap(10);
      },
      itemCount: data.specifications.length,
    );
  }
}

class ProductDescriptionView extends StatelessWidget {
  ProductDescriptionView({super.key});

  final VMProductDetail data = Get.find();

  @override
  Widget build(BuildContext context) {
    return Text(
      data.product.value?.description ?? '',
      style: const TextStyle(
        fontSize: 14,
      ),
    );
  }
}


class ProductRatingOverView extends StatefulWidget {


  const ProductRatingOverView({super.key} );

  @override
  State<ProductRatingOverView> createState() => _ProductRatingOverViewState();
}

class _ProductRatingOverViewState extends State<ProductRatingOverView> {
  final VMProductDetail data = Get.find();
  late final List<MProductDetail> relatedProd;
  bool relatedProductprogress=false;
  @override
  void initState() {
    // TODO: implement initState
    relatedProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hSpace).copyWith(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Rating',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const Gap(10),
          RatingBar.builder(
            initialRating: data.product.value?.totalrating ?? 0,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 20,
            ignoreGestures: true,
            itemPadding: const EdgeInsets.only(right: 2.0),
            unratedColor: Colors.grey.shade400,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (double value) {},
          ),
          const Gap(10),
          Text(
            '(${data.product.value?.ratings.length ?? 0} Ratings)',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const Gap(4),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (con, index) {
              return Row(
                children: [
                  Text(
                    '${5 - index} star',
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    color: Colors.grey.shade300,
                    height: 12,
                    width: 90,
                  ),
                  const Gap(10),
                  const Text(
                    '0%',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (con, index) {
              return const Gap(4);
            },
            itemCount: 5,
          ),
          const Gap(12),
          const Text(
            'Related Products',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const Gap(5),


          relatedProductprogress? Center(
            child: CircularProgressIndicator(
              color: appthemecolor1, // Replace with your color
            ),
          ):Container(
            // margin: EdgeInsets.symmetric(horizontal: hSpace),
            height: MediaQuery.of(context).size.height*0.25,
            margin: const EdgeInsets.only(right: 0, left: 0, top: 1,bottom: 10),

            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: HexColor('#f1f1f1'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GridView.builder(

              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 1,
                crossAxisSpacing: 0,
                childAspectRatio: 1,
                mainAxisSpacing: 10,

              ),
              itemCount: relatedProd.length,
              itemBuilder: (con, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RelatedproductDetailScreen(

                          relatedProd[index].id,
                          relatedProd[index].productName,
                          relatedProd[index].images,
                          relatedProd[index].price,
                          relatedProd[index].mrp,
                          relatedProd[index].ratings,
                          relatedProd[index].totalrating,
                          relatedProd[index].description,
                          relatedProd[index].category,
                          relatedProd[index].partNumber,
                          relatedProd[index].keyword,
                          relatedProd[index].variant,
                          relatedProd[index].weight,
                          relatedProd[index].weightClass,

                      )));
                       });
                  },
                  child: RelatedProductGridItemView(
                      data: relatedProd[index]
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<String> relatedProduct() async {
    try{
      setState(() {
        relatedProductprogress=true;
      });
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      String url = "https://api.sparewares.com/product/searchProduct?category=${data.product.value!.category}";

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
            var resultsList=results['data'] as List;
            relatedProd = resultsList.map((taskJson) => MProductDetail.fromJson(taskJson)).toList();
            relatedProductprogress=false;
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

class ProductSocialShareView extends StatelessWidget {
  const ProductSocialShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        icon: Icon(
          Icons.share,
          size: 20,
          shadows: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}

class RelatedProductGridItemView extends StatelessWidget {
  const RelatedProductGridItemView({super.key, required this.data});
  final MProductDetail data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: WebImageView(
                  data.images.firstOrNull?.imageUrl
              ),
            ),
          ),
          Text(
            data.productName,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: const TextStyle(fontSize: 13),
          ),
          Text(
            "₹ ${data.price.toStringAsFixed(2)}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
          const Gap(2),
          Text.rich(
            TextSpan(
              text: 'MRP ',
              style: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(0.6)),
              children: [
                TextSpan(
                  text: data.mrp.toStringAsFixed(2),
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.black.withOpacity(0.6),
                  ),
                ),
                TextSpan(
                  text:
                  '  ${((1.0 - (data.price / data .mrp)) * 100).toStringAsFixed(0)}% OFF',
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 10
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

