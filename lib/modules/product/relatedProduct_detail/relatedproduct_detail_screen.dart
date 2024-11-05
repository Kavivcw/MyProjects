import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/modules/product/relatedProduct_detail/related_product_model.dart';
import 'package:sparebess/modules/product/product_detail/vm_product_detail.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../views/dot_indicator.dart';
import '../../../views/web_image_view.dart';
import '../../cart/cart_screen.dart';
import '../product_detail/product_detail_screen.dart';




  class RelatedproductDetailScreen extends StatefulWidget {
  String id;
  String productName;
  List<String> images;
  double price;
  var mrp;
  List ratings;
  var totalrating;
  String description;
  String category;
  String partnumber;
  String makeby;
  String varient;
  String weight;
  String weightclass;
  final VMProductDetail data = Get.find();


  RelatedproductDetailScreen(
      this.id,
      this.productName,
      this.images,
      this.price,
      this.mrp,
      this.ratings,
      this.totalrating,
      this.description,
      this.category,
      this.partnumber,
      this.makeby,
      this.varient,
      this.weight,
      this.weightclass,
      );

  @override
  State<RelatedproductDetailScreen> createState() => _RelatedproductDetailScreenState();
  }

  class _RelatedproductDetailScreenState extends State<RelatedproductDetailScreen> {
    final currentIndex = 0.obs;
    final CarouselSliderController _controller = CarouselSliderController();
    final cartState = LoadingState(initialState: RxStatus.success());

    final wishlistState = LoadingState(initialState: RxStatus.success());
    final buyNowState = LoadingState(initialState: RxStatus.success());
    final cartCount = 1.obs;
    int productCount=1;
    bool addcartprogress= false;
    bool buttonchange= false;
    bool buynowProgress= false;
  @override
  void initState() {
  // TODO: implement initState


  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(
        title: 'Product Details',
        actions: [],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  widget.images.isNotEmpty? CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        aspectRatio: 1.9,
                        disableCenter: true,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          currentIndex.value = index;
                        }),
                    items: widget.images.map((imageUrl) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          color: Colors.grey.shade50,
                          child: WebImageView(
                              widget.images.firstOrNull?.imageUrl,
                              )
                        ),
                      );
                    }).toList(),
                  ):  Image.asset(
                    'assets/images/logo_red.png',
                    height: 200,
                    width: 200,
                  ),
                  DotIndicator(
                    currentIndex: currentIndex,
                    total: widget.images.length,
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
                      widget.productName,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        Text(widget.totalrating.toStringAsFixed(1)),
                        const Gap(5),
                        RatingBar.builder(
                          initialRating: max(0.5, widget.totalrating),
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
                        Text(' (${widget.ratings.length} ratings)'),
                      ],
                    ),
                    const Gap(10),
                    Text(
                      priced(widget.price),
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
                            text: priced(widget.mrp),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          TextSpan(
                            text:
                            '  ${((1.0 - (widget.price / widget.mrp)) * 100).toStringAsFixed(0)}% OFF',
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
                                  setState(() {
                                    productCount=max(1,productCount-1);
                                  });

                                  /*widget.data.cartCount.value = max(1, widget.data.cartCount.value - 1);
                                  widget.data.isShowAddToCart.value = true;*/
                                },
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: appthemecolor1,
                                ),
                              ),
                              SizedBox(
                                // width: 30,
                                child: Text(
                                    productCount.toString(),
                                    textAlign: TextAlign.center,
                                  ),

                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    productCount=min(10,productCount+1);
                                  });

                                 /* widget.data.cartCount.value =
                                      min(10, widget.data.cartCount.value + 1);
                                  widget.data.isShowAddToCart.value = true;*/
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
                         buttonchange==true?
                         ElevatedButton(
                           onPressed: () {
                             setState(() {
                               Get.to(() => CartScreen());
                             });
                           },
                           style: ElevatedButton.styleFrom(
                             backgroundColor: appthemecolor2,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12), // <-- Radius
                             ),
                             shadowColor: Colors.black.withOpacity(0.8),
                             elevation: 8,
                           ),
                           child: const Text('Go to Cart',
                             style: TextStyle(
                                 fontSize: 14,
                                 height: 1,
                                 fontWeight: FontWeight.w700,
                                 color: Colors.white
                             ),),
                         ):
                         ElevatedButton(
                          onPressed: () {
                            setState(() {

                              addcartprogress=true;
                              AddtoCart(widget.id,productCount,widget.price);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appthemecolor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                            shadowColor: Colors.black.withOpacity(0.8),
                            elevation: 8,
                          ),
                          child: addcartprogress?const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ): const Text('Add to Cart',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),),
                        ),


                      ],
                    ),
                  ],
                ),
              ),

              ProductDetailSocialMediaView(),

              // RelatedProductListView(),
              ProductRatingOverView(
                  widget.category,
                  widget.partnumber,
                  widget.makeby,
                  widget.varient,
                  widget.weight,
                  widget.weightclass
              ),
              const Gap(1),

            ],
          ),
        ),
      ),
      bottomNavigationBar:
         Container(
          margin: EdgeInsets.only(bottom: defaultBottomPadding()),
          child: Row(
            children: [
              buynowProgress?Padding(
                padding: const EdgeInsets.fromLTRB(180,0,0,0),
                child:  SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: appthemecolor2,
                  ),
                ),
              ):Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: hSpace),
                  child: AppButton(
                    fontSize: 15,
                    height: 38,
                    title: 'Buy Now',
                    state: buyNowState,
                    onPressed: () {
                          setState(() {
                            buynowProgress=true;
                            BuyNow(widget.id,productCount,widget.price);
                          });
                    }
                       // : null,
                  ),
                ),
              ),
            ],
          ),
        ),



    );
  }
    Future<String> AddtoCart(String productId,int productQty,double productPrice) async {
      try{
        final SharedPreferences tokenprefs = await SharedPreferences.getInstance();

        Map<String, dynamic> requestBody = {
          "cart_product_product_Id": productId,
          "cart_quantity": productQty,
          "cart_price": productPrice,
        };
        // Convert the JSON body to a string
        String  requestBodyJson = json.encode(requestBody);

        String url = "https://api.sparewares.com/cart/cart_add";


        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
          },
          body: requestBodyJson,
        );
        setState(() {
          print("adddd_data");
          print(url);
          print(requestBodyJson);
           print(response.body);
          print(tokenprefs.getString('accessToken'));

          String mlconvertdata = utf8.decode(response.bodyBytes);
          if (mlconvertdata != "") {
            if (jsonDecode(mlconvertdata) != null ) {
              var results = jsonDecode(mlconvertdata);

              if(results['success']==true){

                addcartprogress=false;
                buttonchange=true;
                Get.showSnackbar(
                  const GetSnackBar(
                    message: "Added Successfully",
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              else{
                  addcartprogress=false;
                  Get.showSnackbar(
                    const GetSnackBar(
                      message: "Something Wrong",
                      duration: Duration(seconds: 2),
                    ),
                  );
              }
            }
          }
        });

      }

      catch(err){

        print(err);
      }
      return "Successfull";
    }

    Future<String> BuyNow(String productId,int productQty,double productPrice) async {
      try{
        final SharedPreferences tokenprefs = await SharedPreferences.getInstance();

        Map<String, dynamic> requestBody = {
          "cart_product_product_Id": productId,
          "cart_quantity": productQty,
          "cart_price": productPrice,
        };
        // Convert the JSON body to a string
        String requestBodyJson = json.encode(requestBody);

        String url = "https://api.sparewares.com/cart/cart_add";


        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${tokenprefs.getString('accessToken')}"
          },
          body: requestBodyJson,
        );
        setState(() {

          String mlconvertdata = utf8.decode(response.bodyBytes);
          if (mlconvertdata != "") {
            if (jsonDecode(mlconvertdata) != null ) {
              var results = jsonDecode(mlconvertdata);

              if(results['success']==true){
                setState(() {
                  buynowProgress=false;
                  Get.to(() => CartScreen());
                });

              }
              else{
                setState(() {
                  buynowProgress=false;
                });

              }

            }
          }
        });

      }

      catch(err){

        print(err);
      }
      return "Successfull";
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

class RelatedProductDetailView extends StatefulWidget {


  const RelatedProductDetailView({super.key});

  @override
  State<RelatedProductDetailView> createState() => _RelatedProductDetailViewState();
}

class _RelatedProductDetailViewState extends State<RelatedProductDetailView> {


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
                    onRatingUpdate: (double value) {},
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
          Gap(10),
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
                        spreadRadius: 1),
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
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }
}


class ProductRatingOverView extends StatefulWidget {

  String category;
  String partnumber;
  String makeby;
  String varient;
  String weight;
  String weightclass;
  ProductRatingOverView(this.category,this.partnumber,this.makeby,this.varient,this.weight,this.weightclass );

  @override
  State<ProductRatingOverView> createState() => _ProductRatingOverViewState();
}
class _ProductRatingOverViewState extends State<ProductRatingOverView> {
  final VMProductDetail data = Get.find();
  bool relatedProductprogress=false;
  late final List<MProductDetail> relatedProd;

  @override
  void initState() {
    // TODO: implement initState
    relatedProduct();
    super.initState();
  }

  Future<String> relatedProduct() async {
    try{
      setState(() {
        relatedProductprogress=true;
      });
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      String url = "https://api.sparewares.com/product/searchProduct?category=${widget.category}";
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
    return "Successfully";
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: hSpace).copyWith(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Specification',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          const Divider(
            indent: 0,
            endIndent: 270,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Part Number',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                        'Made by',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
              ),
                    Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Varient',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Weight',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Weight class',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
            ],
          ),
              const SizedBox(width: 80,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text(
                    widget.partnumber,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.makeby,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.category,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.varient,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.weight,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.weightclass,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
           ]
          ),
          const Gap(20),
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
            style: TextStyle(
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
                    style: TextStyle(
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
                  Text(
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
            padding: EdgeInsets.all(6),
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

                      //Get.to(() => ProductDetailScreen(id: relatedProd[index].id));
                      // Get.to(() => RelatedproductDetailScreen(id: relatedProd[index].id));
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

