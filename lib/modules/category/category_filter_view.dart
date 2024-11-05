import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../shared/constant.dart';
import '../../shared/theme.dart';
import 'vm_category.dart';
import 'vm_category_filter.dart';

class CategoryFilterView extends StatelessWidget {
  CategoryFilterView({super.key});

  final VMCategory data = Get.find();

  @override
  Widget build(BuildContext context) {
    final allFilters = data.filters.allFilters;
    return SafeArea(
      child: Container(
        // color: Colors.red,
        margin: const EdgeInsets.only(
          top: 44,
          left: hSpace,
        ),
        // padding: EdgeInsets.only(bottom: hSpace),
        child: SingleChildScrollView(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: hSpace, top: hSpace),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (con, index) {
              return CategoryFilterSectionView(data: allFilters[index]);
            },
            separatorBuilder: (con, index) {
              return const Gap(10);
            },
            itemCount: allFilters.length,
          ),
        ),
      ),
    );
  }
}

class CategoryFilterSectionView extends StatelessWidget {
  CategoryFilterSectionView({super.key, required this.data});
  final VMCategory categoryData = Get.find();
  final VMCategoryFilterSection data;
  onChangeSelection(CategoryFilterItemable item, bool? value) {
    if (data.isMultiSelection) {
      item.isSelected.value = (value ?? false);
    } else {
      if (item == data.selected.value) {
        data.selected.value = null;
      } else {
        data.selected.value = item;
      }
    }
    categoryData.getProductsWithDebounce();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE3E4E7),
        borderRadius: BorderRadius.circular(5),
      ),
      // padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              data.title,
              style: TextStyle(
                  color: appthemecolor1,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
          const Gap(2),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemCount: data.arrItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (con, index) {
                  final item = data.arrItems[index];
                  return GestureDetector(
                    onTap: () {
                      final value = !item.isSelected.value;
                      onChangeSelection(item, value);
                    },
                    child: Container(
                      color: Colors.white.withOpacity(0.0001),
                      child: Row(
                        children: [
                          Obx(() {
                            if (data.isMultiSelection) {
                              return SizedBox(
                                height: 30,
                                width: 30,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    value: item.isSelected.value,
                                    checkColor: Colors.white,
                                    activeColor: appthemecolor1,
                                    side: const BorderSide(width: 1),
                                    focusColor: Colors.green,
                                    visualDensity: VisualDensity.compact,
                                    onChanged: (value) {
                                      onChangeSelection(item, value);
                                    },
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 30,
                                width: 30,
                                child: AbsorbPointer(
                                  child: Radio(
                                    value: item,
                                    groupValue: data.selected.value,
                                    activeColor: appthemecolor1,
                                    onChanged: (value) {
                                      onChangeSelection(item, true);
                                      // data.selected.value = null;
                                    },
                                  ),
                                ),
                              );
                            }
                          }),
                          Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const Gap(15),
        ],
      ),
    );
  }
}
