import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/controller/wish_list_controller.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/manager/network_manager/requests/product_request.dart';
import 'package:sparebess/models/data_model/m_banner.dart';
import 'package:sparebess/models/data_model/m_brands.dart';
import 'package:sparebess/models/data_model/m_product.dart';
import 'package:sparebess/models/params/param_add_cart.dart';
import 'package:sparebess/shared/constant.dart';

final class VMHome extends GetxController {
  final bannerState = LoadingState();
  final brandState = LoadingState();
  final productState = LoadingState();
  final banners = <MBanner>[].obs;
  final brands = <MBrand>[].obs;
  // final products = <MProduct>[].obs;
  final PagingController<int, MProduct> pagingController =
      PagingController(firstPageKey: 0);
  @override
  void onInit() {
    setup();
    super.onInit();
  }

  setup() async {
    scBanners();
    scBrands();
    await WishListController.to.scLoadWishList();
    scProducts();
  }

  scBanners() async {
    try {
      final response = await ProductRequest.banners().load(state: bannerState);
      banners.value = response.data;
      bannerState.updateSuccess(banners.isNotEmpty);
    } finally {}
  }

  scBrands() async {
    try {
      final response = await ProductRequest.brands().load(state: brandState);
      brands.value = response.marquee;
      brandState.updateSuccess(brands.isNotEmpty);
    } finally {

    }
  }

  scProducts() async {
    try {
      final response =
          await ProductRequest.productList(ProductListEndPoint.mostSelled)
              .load(state: productState);
      pagingController.appendLastPage(response.data);
      productState.updateSuccess(response.data.isNotEmpty);
    } finally {}
  }

  scAddToCart(ParamAddCart param, LoadingState state) async {
    try {
      final response = await OrderRequest.addToCart(param).load(state: state);
      CartController.to.scUpdateCartCount();
      showToast("Item added to cart successfully");
    } catch (e) {
      showToast(e);
    }
  }
}


final class VMHome2 extends GetxController {
  final bannerState = LoadingState();
  final brandState = LoadingState();
  final productState = LoadingState();
  final banners = <MBanner>[].obs;
  final brands = <MBrand>[].obs;
  // final products = <MProduct>[].obs;
  final PagingController<int, MProduct> pagingController =
  PagingController(firstPageKey: 0);
  @override
  void onInit() {
    setup();
    super.onInit();
  }

  setup() async {
    scBanners();
    scBrands();
    await WishListController.to.scLoadWishList();
    scProducts();
  }

  scBanners() async {
    try {
      final response = await ProductRequest.banners().load(state: bannerState);
      banners.value = response.data;
      bannerState.updateSuccess(banners.isNotEmpty);
    } finally {}
  }

  scBrands() async {
    try {
      final response = await ProductRequest.brands().load(state: brandState);
      brands.value = response.marquee;
      brandState.updateSuccess(brands.isNotEmpty);
    } finally {

    }
  }

  scProducts() async {
    try {
      final response =
      await ProductRequest.productList(ProductListEndPoint.mostSelled)
          .load(state: productState);
      pagingController.appendLastPage(response.data);
      productState.updateSuccess(response.data.isNotEmpty);
    } finally {}
  }

  scAddToCart(ParamAddCart param, LoadingState state) async {
    try {
      final response = await OrderRequest.addToCart(param).load(state: state);
      CartController.to.scUpdateCartCount();
      showToast("Item added to cart successfully");
    } catch (e) {
      showToast(e);
    }
  }
}