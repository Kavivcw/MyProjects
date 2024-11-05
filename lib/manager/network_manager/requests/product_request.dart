import 'package:get/get.dart';
import 'package:sparebess/models/data_model/m_banner.dart';
import 'package:sparebess/models/data_model/m_brands.dart';
import 'package:sparebess/models/data_model/m_category_filter_list.dart';
import 'package:sparebess/models/data_model/m_category_list_response.dart';
import 'package:sparebess/models/data_model/m_product.dart';
import 'package:sparebess/models/data_model/m_product_detail.dart';
import 'package:sparebess/models/params/param_product_filter.dart';

import '../request.dart';

abstract class ProductRequest {
  static Request<MBannerResponse> banners() {
    return Request(
      MBannerResponse.new,
      endPoint: 'sliderget',
      path: Path.user,
      method: Method.get,
    );
  }

  static Request<MCategoryListResponse> categoryList() {
    return Request(
      MCategoryListResponse.new,
      endPoint: 'fetch_category',
      path: 'category',
      method: Method.get,
    );
  }

  static Request<MBrandListResponse> brands() {
    return Request(
      MBrandListResponse.new,
      endPoint: 'get-tag',
      path: 'marquee',
      method: Method.get,
    );
  }

  static Request<MProductListResponse> productList(String endPoint) {
    return Request(
      MProductListResponse.new,
      endPoint: endPoint,
      path: 'product',
      method: Method.get,
    );
  }

  static Request<MProductDetailResponse> productDetail(String id) {
    return Request(
      MProductDetailResponse.new,
      endPoint: 'getproductId/$id',
      path: 'product',
      method: Method.get,
    );
  }

  static Request<MProductListResponse> filteredProducts(
      ParamProductFilter param) {
    // Construct and log the URLxs
    final queryString = param.queryString.replaceFirst('&', '?');
    final url = 'searchProduct$queryString';
    print('API URLlll: $url');
    return Request(
      MProductListResponse.new,
      endPoint: 'searchProduct${param.queryString.replaceFirst('&', '?')}',
      path: 'product',
      method: Method.get,
    );
  }

  static Request<MCategoryFilterListResponse> variants() {
    return Request(
      MCategoryFilterListResponse.new,
      endPoint: 'varient_fetch',
      path: 'varient',
      method: Method.get,
    );
  }

  static Request<MCategoryFilterListResponse> models() {
    return Request(
      MCategoryFilterListResponse.new,
      endPoint: 'model_fetch',
      path: 'model',
      method: Method.get,
    );
  }

  static Request<MCategoryFilterListResponse> manufactures() {
    return Request(
      MCategoryFilterListResponse.new,
      endPoint: 'manufacture_fetch',
      path: 'manufacture',
      method: Method.get,
    );
  }
}

abstract class ProductListEndPoint {
  static const mostSelled = 'mostselled';
}
