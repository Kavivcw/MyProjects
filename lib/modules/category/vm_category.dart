import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/models/data_model/m_product.dart';
import 'package:sparebess/models/params/param_product_filter.dart';
import 'package:sparebess/modules/category/vm_category_filter.dart';
import 'package:sparebess/shared/constant.dart';

import '../../manager/network_manager/requests/product_request.dart';
import '../../models/data_model/m_category_list_response.dart';

final class VMCategory extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final state = LoadingState();
  // final searchState = LoadingState();
  final focusNode = FocusNode();
  final filters = VMCategoryFilter();
  final PagingController<int, MProduct> pagedGridController =
      PagingController(firstPageKey: 1);
  VMCategoryFilterSection<MCategory> get categoryFilter {
    return filters.categoryFilter;
  }

  final allCategory = MCategory(
    id: '0',
    name: 'All Category',
    desc: '',
    image: '',
    isDeleted: false,
    createdAt: DateTime.now(),
    v: 0,
  );
  final searchDebouncer = Debouncer(delay: const Duration(seconds: 1));

  @override
  void onReady() {
    super.onReady();
    setup();
    pagedGridController.addPageRequestListener((page) {
      getProducts(page: page);
    });
  }

  resetAllFilters() {
    filters.reset();
  }

  setup() {
    scCategory();
    scManufactures();
    scVariants();
    scModels();
    getPrices();
    getProducts();
  }

  getProducts({int page = 1}) async {
    if (page == 1) {
      pagedGridController.itemList?.clear();
      state.value = RxStatus.loading();
    }
    final param = filters.filterParam;
    param.page = page;
    scFilteredProducts(param);
  }

  scFilteredProducts(ParamProductFilter param) async {
    try {
      print("check1");
      print(param);
      print("check2");
      final response = await ProductRequest.filteredProducts(param).load();
      print("API call completed. Response details:");
      print(response); // Print the entire response object
      print("Response data:");
      print(response.data); // Print the data part of the response
      print("Response message:");
      print(response.message); // Print any message included in the response
      print("Response data length:");
      print(response.data.length); // Print the length of the data

      print(response.data.length);
      if (response.data.length < 12) {
        pagedGridController.appendLastPage(response.data);
      } else {
        pagedGridController.appendPage(response.data, param.page + 1);
      }
      state.updateSuccess(pagedGridController.itemList?.isNotEmpty ?? false);
    } finally {}
  }

  getProductsWithDebounce() {
    if (!state.isLoading) {
      state.value = RxStatus.loading();
    }
    searchDebouncer.call(() async {
      await getProducts();
    });
  }

  toggleDrawer() {
    if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
      scaffoldKey.currentState?.closeDrawer();
    } else {
      scaffoldKey.currentState?.openDrawer();
    }
  }

  scCategory() async {
    categoryFilter.selected.value = allCategory;
    try {
      final response =
          await ProductRequest.categoryList().load(state: categoryFilter.state);
      categoryFilter.arrItems.value = [allCategory] + response.category;
      categoryFilter.state.updateSuccess(categoryFilter.arrItems.isNotEmpty);
    } finally {}
  }

  scManufactures() async {
    try {
      final response = await ProductRequest.manufactures().load();
      filters.manufactureFilter.arrItems.value = response.categories;
    } finally {}
  }

  scVariants() async {
    try {
      final response = await ProductRequest.variants().load();
      filters.variantFilter.arrItems.value = response.categories;
    } finally {}
  }

  scModels() async {
    try {
      final response = await ProductRequest.models().load();
      filters.modelFilter.arrItems.value = response.categories;
    } finally {}
  }

  getPrices() {
    filters.priceFilter.arrItems.addAll([
      VMCategoryPriceFilterItem(
        minValue: 300,
        maxValue: 300,
      ),
      VMCategoryPriceFilterItem(
        minValue: 500,
        maxValue: 500,
      ),
      VMCategoryPriceFilterItem(
        minValue: 1000,
        maxValue: 1000,
      ),
      VMCategoryPriceFilterItem(
        minValue: 1500,
        maxValue: 1500,
      ),
    ]);
  }
}

final class VMCategoryPriceFilterItem implements CategoryFilterItemable {
  @override
  final isSelected = false.obs;

  @override
  late final String name;
  final double minValue;
  final double maxValue;

  VMCategoryPriceFilterItem({
    String? name,
    required this.minValue,
    required this.maxValue,
  }) {
    if (name != null) {
      this.name = name;
    } else {
      this.name = 'Above ${priced(minValue)}';
    }
  }
}
