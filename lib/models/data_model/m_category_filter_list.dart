import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sparebess/modules/category/vm_category_filter.dart';

class MCategoryFilterListResponse {
  final bool success;
  final List<MCategoryFilterItem> categories;

  MCategoryFilterListResponse.named({
    required this.success,
    required this.categories,
  });

  factory MCategoryFilterListResponse(Map<String, dynamic> json) =>
      MCategoryFilterListResponse.named(
        success: json["success"],
        categories: List<MCategoryFilterItem>.from(
            (json["Categories"] ?? json['manufactures'])
                .map((x) => MCategoryFilterItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class MCategoryFilterItem implements CategoryFilterItemable {
  final String id;
  @override
  final String name;
  final String desc;
  final bool isDeleted;
  final DateTime createdAt;
  final int v;

  MCategoryFilterItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.isDeleted,
    required this.createdAt,
    required this.v,
  });

  factory MCategoryFilterItem.fromJson(Map<String, dynamic> json) =>
      MCategoryFilterItem(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "__v": v,
      };

  @override
  Rx<bool> isSelected = false.obs;
}
