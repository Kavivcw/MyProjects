import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sparebess/models/data_model/m_category_filter_list.dart';
import 'package:sparebess/models/data_model/m_category_list_response.dart';
import 'package:sparebess/models/params/param_product_filter.dart';
import 'package:sparebess/modules/category/vm_category.dart';
import 'package:sparebess/shared/constant.dart';

abstract class CategoryFilterItemable {
  String get name;
  Rx<bool> get isSelected;
}

class NoFilterDataItem extends CategoryFilterItemable {
  @override
  final isSelected = false.obs;

  @override
  final name = 'No Data';
}

extension CategoryFilterItemableExtension<T extends CategoryFilterItemable>
    on List<T> {
  List<T> get filtered {
    return where((element) => element.isSelected.value).toList();
  }
}

final class VMCategoryFilterSection<T extends CategoryFilterItemable> {
  final selected = Rxn<T>(null);
  final arrItems = <T>[].obs;
  final String title;
  final isSeeMore = Rxn<bool>(null);
  updateSelection(T item) {}
  final bool isMultiSelection;
  final state = LoadingState(initialState: RxStatus.success());
  VMCategoryFilterSection({this.isMultiSelection = true, required this.title});
  List<T> get filtered {
    return arrItems.filtered;
  }

  replaceSingleToMultiple() {
    for (final element in arrItems) {
      if (element == selected.value) {
        element.isSelected.value = true;
      } else {
        element.isSelected.value = false;
      }
    }
  }

  reset({bool resetSingleSelection = true}) {
    if (resetSingleSelection) {
      selected.value = null;
    }
    for (var element in arrItems) {
      element.isSelected.value = false;
    }
  }
}

final class VMCategoryFilter {
  final manufactureFilter = VMCategoryFilterSection<MCategoryFilterItem>(
      title: "Vehicle Manufacture");
  final variantFilter =
      VMCategoryFilterSection<MCategoryFilterItem>(title: 'Vehicle Variant');
  final modelFilter =
      VMCategoryFilterSection<MCategoryFilterItem>(title: "Vehicle Model");
  final priceFilter = VMCategoryFilterSection<VMCategoryPriceFilterItem>(
      title: "Price", isMultiSelection: false);
  final categoryFilter = VMCategoryFilterSection<MCategory>(title: 'Category');
  final searchController = TextEditingController();

  List<VMCategoryFilterSection> get allFilters {
    return [manufactureFilter, variantFilter, modelFilter, priceFilter];
  }

  reset({bool resetSingleSelection = true}) {
    searchController.clear();
    manufactureFilter.reset(resetSingleSelection: resetSingleSelection);
    variantFilter.reset(resetSingleSelection: resetSingleSelection);
    modelFilter.reset(resetSingleSelection: resetSingleSelection);
    priceFilter.reset(resetSingleSelection: resetSingleSelection);
    if (resetSingleSelection) {
      final category = Get.find<VMCategory>();
      categoryFilter.selected.value = category.allCategory;
    }
  }

  ParamProductFilter get filterParam {
    return ParamProductFilter(
      category: categoryFilter.selected.value?.id == '0'
          ? null
          : categoryFilter.selected.value,
      manufacture: manufactureFilter.filtered,
      variant: variantFilter.filtered,
      model: modelFilter.filtered,
      minAmount: priceFilter.selected.value?.minValue,
      // maxAmount: priceFilter.selected.value?.maxValue,
      keyword: searchController.text,
    );
  }

  // ParamProductFilter get singleSelectionParam {
  //   return ParamProductFilter(
  //     category: categoryFilter.selected.value?.id == '0'
  //         ? null
  //         : categoryFilter.selected.value,
  //     manufacture: [manufactureFilter.selected.value].compactMap().toList(),
  //     variant: [variantFilter.selected.value].compactMap().toList(),
  //     model: [modelFilter.selected.value].compactMap().toList(),
  //     minAmount: null,
  //     maxAmount: null,
  //     keyword: searchController.text,
  //   );
  // }
}
