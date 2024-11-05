import 'package:sparebess/models/data_model/m_category_filter_list.dart';
import 'package:sparebess/models/data_model/m_category_list_response.dart';
import 'package:sparebess/models/params/paramable.dart';

class ParamProductFilter implements Encodable {
  MCategory? category;
  List<MCategoryFilterItem> manufacture = [];
  List<MCategoryFilterItem> variant = [];
  List<MCategoryFilterItem> model = [];
  double? minAmount;
  // double? maxAmount;
  int page;
  final String? keyword;
  ParamProductFilter({
    this.page = 1,
    required this.keyword,
    required this.category,
    required this.manufacture,
    required this.variant,
    required this.model,
    required this.minAmount,
    // required this.maxAmount,
  });

  bool get isValidFilter {
    final validations = [
      category != null,
      manufacture.isNotEmpty,
      variant.isNotEmpty,
      model.isNotEmpty,
      minAmount != null,
      // maxAmount != null
    ];
    return validations.contains(true);
  }

  String get queryString {
    String string = '';
    if (category?.name != null) {
      string += '&keyword=${category!.name}';
    }
    if (keyword?.isNotEmpty ?? false) {
      string += '&keyword=$keyword';
    }
    string += manufacture.map((e) => '&manufacture=${e.name}').join();
    string += variant.map((e) => '&variant=${e.name}').join();
    string += model.map((e) => '&model=${e.name}').join();
    string += '&page=$page';

    if (minAmount != null) {
      string += '&price=$minAmount';
    }
    return string;
  }

  @override
  Map<String, dynamic> toJson() => {
        "category": category?.name ?? '',
        "manufacture": List<String>.from(manufacture.map((x) => x.name)),
        "variant": List<String>.from(variant.map((x) => x.name)),
        "model": List<String>.from(model.map((x) => x.name)),
        "price": minAmount,
        // "maxAmount": maxAmount,
      };
}
