import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/home_controller.dart';
import 'package:sparebess/modules/category/vm_category_filter.dart';

import '../../shared/constant.dart';
import '../../views/app_button.dart';
import '../category/vm_category.dart';
import 'home_screen.dart';

class HomeDropdownView extends StatelessWidget {
  HomeDropdownView({super.key});

  final VMCategory category = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      /*  const HomeSectionTitleView(title: 'Search by Vehicle'),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: hSpace),
          child: Text(
            'Filter your results by entering your Vehicle to ensure you find the parts that fit',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF848484),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Gap(12),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: hSpace),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.red),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  HomeDropdownItemView(data: category.categoryFilter),
                  const Gap(10),
                  HomeDropdownItemView(
                      data: category.filters.manufactureFilter),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  HomeDropdownItemView(data: category.filters.modelFilter),
                  const Gap(10),
                  HomeDropdownItemView(data: category.filters.variantFilter),
                ],
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    title: 'Search',
                    fontSize: 13,
                    height: 30,
                    onPressed: () {
                      // final param = category.filters.singleSelectionParam;
                      // category.getProducts(filterParam: param);
                      for (var element in category.filters.allFilters) {
                        element.replaceSingleToMultiple();
                      }
                      category.getProducts();
                      HomeController.to.tabIndex = 1;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),*/
      ],
    );
  }
}

class HomeDropdownItemView extends StatelessWidget {
  const HomeDropdownItemView({super.key, required this.data});

  final VMCategoryFilterSection data;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(2, 2))
            ]
            // border: Border.all(color: appthemecolor1),
            ),
        child: Obx(
          () {
            if (data.arrItems.isNotEmpty) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2<CategoryFilterItemable>(
                  isExpanded: true,
                  // isDense: true,
                  hint: Text(
                    data.title,
                    style: const TextStyle(fontSize: 11),
                  ),
                  value: data.selected.value,

                  // icon: const Padding(
                  //   padding: EdgeInsets.only(right: 1),
                  //   child: Icon(
                  //     Icons.keyboard_arrow_down_outlined,
                  //     size: 20,
                  //   ),
                  // ),
                  onChanged: (newValue) {
                    data.selected.value = newValue;
                  },
                  items: data.arrItems.map((item) {
                    return DropdownMenuItem<CategoryFilterItemable>(
                      value: item,
                      child: Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            } else {
              return DropdownButtonHideUnderline(
                child: DropdownButton2<CategoryFilterItemable>(
                  isExpanded: true,
                  // isDense: true,
                  hint: Text(
                    data.title,
                    style: const TextStyle(fontSize: 11),
                  ),
                  value: null,
                  onChanged: (newValue) {},
                  items: [
                    DropdownMenuItem<CategoryFilterItemable>(
                      value: NoFilterDataItem(),
                      child: const Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
