import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/models/data_model/m_category_list_response.dart';
import 'package:sparebess/modules/category/category_filter_view.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/modules/home/home_product_grid_view.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final VMCategory data = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: data.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: 'Categories',
        leading: IconButton(
          onPressed: () {
            data.toggleDrawer();
          },
          icon: const Row(
            children: [
              Icon(Icons.filter_alt_rounded),
            ],
          ),
        ),
        // actions: [
        //   IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            CategorySearchView(isNeedCategory: true),
            Expanded(
              child: HomeProductGridView(
                pagingController: data.pagedGridController,
                state: data.state,
                isExpanded: true,
                isCategoryPage: true,
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: 200,
        clipBehavior: Clip.none,
        child: CategoryFilterView(),
        // shadowColor: Colors.transparent,
        // elevation: 0,
        // surfaceTintColor: Colors.red,
      ),
    );
  }
}

class CategorySearchView extends StatelessWidget {
  CategorySearchView(
      {super.key,
      required this.isNeedCategory,
      this.isEnabled = true,
      this.controller});

  final VMCategory data = Get.find();
  final bool isNeedCategory;
  final bool isEnabled;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(hSpace),
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xFFBCBCBC)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
         // if (isNeedCategory) CategoryDropdownView() else const Gap(10),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    focusNode: data.focusNode,
                    textInputAction: TextInputAction.go,
                    enabled: isEnabled,
                    controller: controller ?? data.filters.searchController,
                    // onTap: () {
                    //   HomeController.to.tabIndex = 1;
                    // },
                    onChanged: (newText) {
                      data.getProductsWithDebounce();
                    },
                    onTapOutside: hideKeyboard,
                    decoration: const InputDecoration(
                      hintText: 'Search for Products...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                Icon(
                  Icons.search,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryDropdownView extends StatefulWidget {
  const CategoryDropdownView({super.key});

  @override
  State<CategoryDropdownView> createState() => _CategoryDropdownViewState();
}

class _CategoryDropdownViewState extends State<CategoryDropdownView> {
  final VMCategory data = Get.find();

  late var categoryFilter = data.filters.categoryFilter;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonHideUnderline(
        child: DropdownButton2<MCategory>(

            isExpanded: true,
            value: categoryFilter.selected.value,
            isDense: true,
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 185,
            ),
            // menuItemStyleData: const MenuItemStyleData(
            //   height: 100,
            // ),
            menuItemStyleData: const MenuItemStyleData(
              height: 58, // Height of each menu item
             // Width of each menu item (Note: This affects the width of the items but not the whole menu)
            ),
            onChanged: (item) {
              categoryFilter.selected.value = item!;
              data.getProducts();
            },
            items: (data.categoryFilter.arrItems).map(
                  (element) => DropdownMenuItem<MCategory>(
                    value: element,
                    child: Text(
                      element.name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList()),
      );
    });
  }
}
