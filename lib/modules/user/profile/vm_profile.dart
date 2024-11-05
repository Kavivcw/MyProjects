import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/modules/order/order_list/order_list_screen.dart';
import 'package:sparebess/modules/order/order_list/vm_order_list.dart';
import 'package:sparebess/modules/other/pricing_detail/pricing_detaile_view.dart';
import 'package:sparebess/views/popup/logout_popup.dart';

import '../../other/about_us/aboutus_view.dart';
import '../../other/cacellation_refund_policy/cancellation_view.dart';
import '../../other/privacy_policy/privacy_policy_view.dart';
import '../../other/terms_and_condition/terms_view.dart';
import '../address/address_list/address_list_screen.dart';
import '../rewards_view.dart';
import '../wish_list/wishlist_screen.dart';

enum EProfileListItem {
  myOrder,
  orderHistory,
  rewards,
  returns,
  refund,
  wishList,
  address,
  notification,
  aboutUs,
  privacyPolicy,
  termsAndConditions,
  cancellationAndRefunds,
  pricingDetails,
  logout;
}

class VMProfileListItem {
  final EProfileListItem type;
  final String name;
  final IconData image;

  VMProfileListItem({
    required this.type,
    required this.name,
    required this.image,
  });
}

class VMProfile extends GetxController {
  final arrMenu = <VMProfileListItem>[];

  @override
  void onInit() {
    super.onInit();
    arrMenu.addAll([
      VMProfileListItem(
        type: EProfileListItem.myOrder,
        name: 'My Orders',
        image: Icons.shopping_bag_outlined,
      ),
      // VMProfileListItem(
      //   type: EProfileListItem.orderHistory,
      //   name: 'Order History',
      //   image: Icons.shopping_bag_outlined,
      // ),
      // VMProfileListItem(
      //     type: EProfileListItem.rewards,
      //     name: 'Rewards',
      //     image: Icons.wallet_giftcard_outlined),
      // VMProfileListItem(
      //     type: EProfileListItem.returns,
      //     name: 'Return',
      //     image: Icons.keyboard_return_outlined),
      // VMProfileListItem(
      //     type: EProfileListItem.refund,
      //     name: 'Refund',
      //     image: Icons.assignment_return_outlined),
      VMProfileListItem(
          type: EProfileListItem.wishList,
          name: 'Wishlist',
          image: Icons.favorite_border_outlined),
      VMProfileListItem(
          type: EProfileListItem.address,
          name: 'Address',
          image: Icons.location_on_outlined),
      // VMProfileListItem(
      //     type: EProfileListItem.notification,
      //     name: 'Notification',
      //     image: Icons.notifications_active_outlined),
      VMProfileListItem(
          type: EProfileListItem.aboutUs,
          name: 'About Us',
          image: Icons.support_agent),
      VMProfileListItem(
          type: EProfileListItem.privacyPolicy,
          name: 'Privacy Policy',
          image: Icons.support_agent),
      VMProfileListItem(
          type: EProfileListItem.termsAndConditions,
          name: 'Terms and Condition',
          image: Icons.support_agent),
      VMProfileListItem(
          type: EProfileListItem.cancellationAndRefunds,
          name: 'Cancellation & Refund Policy',
          image: Icons.support_agent),
      VMProfileListItem(
          type: EProfileListItem.pricingDetails,
          name: 'Pricing Details',
          image: Icons.money_outlined),
      VMProfileListItem(
          type: EProfileListItem.logout, name: 'Logout', image: Icons.logout),
    ]);
  }

  onTapMenu(VMProfileListItem item) {
    switch (item.type) {
      case EProfileListItem.myOrder:
        Get.to(() => OrderListScreen(orderType: EOrderListType.recent));
        break;
      case EProfileListItem.orderHistory:
        Get.to(() => OrderListScreen(orderType: EOrderListType.history));
        break;
      case EProfileListItem.rewards:
        Get.to(() => const RewardsPageView());
        break;
      case EProfileListItem.returns:
        break;
      case EProfileListItem.refund:
        break;
      case EProfileListItem.wishList:
        Get.to(() => WishListScreen());
        break;
      case EProfileListItem.address:
        Get.to(() => AddressListScreen());
        break;
      case EProfileListItem.notification:
        break;
      case EProfileListItem.aboutUs:
        Get.to(() => AboutUsView());
        break;
      case EProfileListItem.privacyPolicy:
        Get.to(() => const PrivacyPolicyView());
        break;
      case EProfileListItem.termsAndConditions:
        Get.to(() => const TermsView());
      case EProfileListItem.cancellationAndRefunds:
        Get.to(
          () => CancellationView(
            title: item.name,
          ),
        );
        break;
      case EProfileListItem.pricingDetails:
        Get.to(() => PricingDetailPolicyScreen());
        break;
      case EProfileListItem.logout:
        Get.bottomSheet(
          const LogoutPopup(),
        );
        break;
    }
  }
}
