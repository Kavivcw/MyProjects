import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/home_controller.dart';
import 'package:sparebess/controller/wish_list_controller.dart';
import 'package:sparebess/modules/category/category_screen.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/modules/home/home_brand_list_view.dart';
import 'package:sparebess/modules/home/vm_home.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';

import '../../controller/auth_controller.dart';
import '../user/wish_list/wishlist_screen.dart';
import 'home_banner_view.dart';
import 'home_category_grid_view.dart';
import 'home_dropdown_view.dart';
import 'home_product_grid_view.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final VMHome data = Get.find();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {


                HomeController.to.tabIndex = 1;
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  final category = Get.find<VMCategory>();
                  category.filters.searchController.clear();
                  category.focusNode.requestFocus();
                });
              },
              child: CategorySearchView(
                isNeedCategory: false,
                isEnabled: false,
                controller: controller,
              ),
            ),
            HomeBannerCarouselView(),
            HomeCategoryGridView(),
            HomeDropdownView(),
            HomeProductGridView(
              state: data.productState,
              sectionTitle: 'Best Seller',
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: data.pagingController,
            ),
            HomeBrandListView(),
            const Gap(hSpace),
          ],
        ),
      ),
    );
  }
}

class HomeSectionTitleView extends StatelessWidget {
  const HomeSectionTitleView({super.key, required this.title});

  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: hSpace, bottom: 10, left: hSpace),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 66,
      backgroundColor: appthemecolor1,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            const Gap(10),
            Image.asset(
              width: 50,
              height: 50,
              'logo_blue'.png,
            ),
            const Gap(15),
        Text(
          AuthController.to.user != null?AuthController.to.user!.userName:"Guest",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                print( AuthController.to.user!.userName);


               Get.to(() => WishListScreen());
              },
              icon: Badge(
                label: Obx(() {
                  return Text(
                    WishListController.to.arrData.length.toString(),
                    style: TextStyle(color: appthemecolor1),
                  );
                }),
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      // leading: Image.asset(
      //   'logo_white'.png,
      //   height: 100,
      // ),
      // title: Text(
      //   AuthController.to.user!.userName,
      //   style: const TextStyle(
      //     color: Colors.white,
      //     fontSize: 18,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      // backgroundColor: appthemecolor1,
      // centerTitle: false,
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(
      //       Icons.favorite_border_outlined,
      //       color: Colors.white,
      //     ),
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
