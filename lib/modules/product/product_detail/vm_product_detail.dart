import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/product_request.dart';
import 'package:sparebess/models/data_model/m_product_detail.dart';
import 'package:sparebess/shared/constant.dart';

import '../../../controller/cart_controller.dart';
import '../../../manager/network_manager/requests/order_request.dart';
import '../../../models/params/param_add_cart.dart';
import '../../cart/cart_screen.dart';

enum EProductDetailTab {
  compatibility,
  specification,
}

class VMSocialMediaShare {
  final String image;
  final String link;

  VMSocialMediaShare({
    required this.image,
    required this.link,
  });
}

final class VMProductDetailSpecItem {
  final String title;
  final String desc;

  VMProductDetailSpecItem(
    this.title,
    this.desc,
  );
}

final class VMProductDetail extends GetxController {
  final state = LoadingState();
  final product = Rxn<MProductDetail>(null);
  final String id;
  final cartCount = 1.obs;
  final selectedTab = EProductDetailTab.compatibility.obs;
  var specifications = <VMProductDetailSpecItem>[];
  final List<VMSocialMediaShare> socialMedia = [
    VMSocialMediaShare(
      image: 'share_instagram',
      link: 'https://www.instagram.com/sparewaresindia', //temp
    ),
    VMSocialMediaShare(
      image: 'share_facebook',
      link: 'https://www.facebook.com/profile.php',
      // link:
      // 'https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.facebook.com%2Fprofile.php%3Fid%3D61559972581211',
    ),
    VMSocialMediaShare(
      image: 'share_twitter',
      // link: 'https://x.com/SpareWaresindia',
      link: 'https://x.com/compose/post',
    ),
    VMSocialMediaShare(
      image: 'share_linkedin',
      link: 'https://www.linkedin.com/company/sparewares',
    ),
    VMSocialMediaShare(
      image: 'share_threads',
      link: 'https://www.threads.net/@sparewaresindia', //temp
    ),
    VMSocialMediaShare(
        image: 'share_reddit',
        link:
            'https://www.reddit.com/submit?url=https%3A%2F%2Fwww.reddit.com%2Fuser%2Fsparewares%2F&type=TEXT'),
  ];
  late final isShowAddToCart = (!isInCart).obs;
  VMProductDetail({required this.id}) {
    scProductDetail();
  }


  bool get isInCart {
    return CartController.to.cartIDs[id] != null;
  }

  scProductDetail() async {
    try {
      final response =
          await ProductRequest.productDetail(id).load(state: state);
      state.updateSuccess(response.products.isNotEmpty);
      final item = response.products.firstOrNull;
      if (item != null) {
        specifications = [
          VMProductDetailSpecItem('Part Number', item.partNumber),
        ];
        if (item.manufacture.isNotEmpty) {
          specifications
              .add(VMProductDetailSpecItem('Make by', item.manufacture));
        }

        if (item.category.isNotEmpty) {
          specifications
              .add(VMProductDetailSpecItem('Category', item.category));
        }
        if (item.variant.isNotEmpty) {
          specifications.add(VMProductDetailSpecItem('Variant', item.variant));
        }
        specifications.add(
          VMProductDetailSpecItem('Weight', item.weight),
        );
        specifications
            .add(VMProductDetailSpecItem('Weight class', item.weightClass));
      } else {}
      product.value = item;
    } catch (e) {}
  }

  addToCart(LoadingState state) async {
    final param = ParamAddCart(
      cartQuantity: cartCount.value,
      cartPrice: product.value!.price,
      cartProductProductId: id,
    );
    final response = await OrderRequest.addToCart(param).load(state: state);
    CartController.to.scUpdateCartCount();
  }

  goToCart(LoadingState state) async {
    if (CartController.to.cartIDs[id] == null) {
      try {
        await addToCart(state);
        Get.to(() => CartScreen());
      } catch (e) {
        showToast(e);
      }
    } else {
      Get.to(() => CartScreen());
    }
  }
}
