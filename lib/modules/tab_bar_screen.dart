import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/controller/cart_controller.dart';
import 'package:sparebess/controller/home_controller.dart';
import 'package:sparebess/controller/wish_list_controller.dart';
import 'package:sparebess/modules/cart/cart_screen.dart';
import 'package:sparebess/modules/category/category_screen.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/modules/home/home_screen.dart';
import 'package:sparebess/modules/home/vm_home.dart';
import 'package:sparebess/modules/user/profile/profile_screen.dart';
import 'package:sparebess/shared/theme.dart';

import '../controller/auth_controller.dart';
import '../models/data_model/m_user.dart';
import 'home/chat_screen.dart';

class TabBarScreen extends StatefulWidget {
  TabBarScreen({super.key});

  final cartController = Get.put(CartController());
  final wishListController = Get.put(WishListController());
  final homeController = Get.put(HomeController());
  final homeData = Get.put(VMHome());
  final categoryController = Get.put(VMCategory());


  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {

  getNavigationbarItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeScreen();
      case 1:
        return CategoryScreen();
      case 2:
        return ProfileScreen();
      case 3:
        return CartScreen();
      default:
        return const Text("Error");
    }
  }

  Widget get cartBadgeLabel {
    return Obx(() {
      return Text(widget.cartController.cartCount.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.red),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: backGColor,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined, color: Colors.black),
                  activeIcon: Icon(Icons.home_outlined, color: appthemecolor1),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  label: 'Categories',
                  icon: Image.asset(
                    'lib/images/icon/categories.png',
                    height: 25.0,
                    width: 25.0,
                    color: Colors.black,
                  ),
                  activeIcon: Image.asset(
                    'lib/images/icon/categories.png',
                    height: 25.0,
                    width: 25.0,
                    color: appthemecolor1,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Account',
                  icon:
                      const Icon(Icons.person_2_outlined, color: Colors.black),
                  activeIcon:
                      Icon(Icons.person_2_outlined, color: appthemecolor1),
                ),
                BottomNavigationBarItem(
                  label: 'Cart',
                  icon: Badge(
                    label: cartBadgeLabel,
                    child: const Icon(Icons.shopping_cart_outlined,
                        color: Colors.black),
                  ),
                  activeIcon: Badge(
                    label: cartBadgeLabel,
                    child: Icon(Icons.shopping_cart_outlined,
                        color: appthemecolor1),
                  ),
                ),
              ],
              currentIndex: HomeController.to.tabIndex,
              selectedItemColor: appthemecolor1,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12.0,
              showSelectedLabels: true,
              onTap: (int index) {
                HomeController.to.tabIndex = index;
              },
              elevation: 5,
            ),
          ),
        ),
        body: getNavigationbarItemWidget(controller.tabIndex),
           floatingActionButton:AuthController.to.user != null? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Semantics(
                label: 'chat',
                child: FloatingActionButton(
                 
                  onPressed: () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                    Navigator.push(context, MaterialPageRoute(builder: (context) => chatScreen()));
                    },
                  tooltip: 'Chat',
                  child:  Icon(Icons.chat,
                  color: appthemecolor2,
                  ),
                ),
              ),
            ],
          ):Container()
      );
    });
  }
}
