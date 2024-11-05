import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/home_controller.dart';
import 'package:sparebess/models/data_model/m_category_list_response.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/modules/home/home_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/web_image_view.dart';

class HomeCategoryGridView extends StatelessWidget {
  HomeCategoryGridView({super.key});
  final VMCategory data = Get.find();
  @override
  Widget build(BuildContext context) {
    return RxStatusView2(
        state: data.categoryFilter.state,
        loader: loader,
        builder: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeSectionTitleView(title: 'Shop by Categories'),
              CategoryGridView(),
            ],
          );
        });
  }

  final Widget loader = Align(
    alignment: Alignment.centerLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeSectionTitleView(title: 'Shop by Categories'),
        Center(
          child: CircularProgressIndicator(
            color: appthemecolor1,
          ),
        ),
      ],
    ),
  );
}

class CategoryGridView extends StatelessWidget {
  CategoryGridView({super.key});
  final VMCategory data = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hSpace),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: appthemecolor1,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
          mainAxisSpacing: 10,
        ),
        itemCount: data.categoryFilter.arrItems.length,
        itemBuilder: (con, index) {
          return GestureDetector(
            onTap: () {

              data.filters.reset();
              data.categoryFilter.selected.value = data.categoryFilter.arrItems[index];
              data.getProducts();
              HomeController.to.tabIndex = 1;
              print("data.getProducts()");

              print(data.categoryFilter.arrItems[index].id);
              print(data.categoryFilter.arrItems[index].name);
              print(data.categoryFilter.selected.value?.name);


            },
            child: HomeCategoryGridItemView(
                data: data.categoryFilter.arrItems[index]),
          );
        },
      ),
    );
  }
}

class HomeCategoryGridItemView extends StatelessWidget {
  const HomeCategoryGridItemView({super.key, required this.data});
  final MCategory data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
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
                data.image,
              ),
            ),
          ),
          Text(
            data.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
