// To parse this JSON data, do
//
//     final mCategoryListResponse = mCategoryListResponseFromJson(jsonString);

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sparebess/modules/category/vm_category_filter.dart';

class MCategoryListResponse {
  final bool success;
  final List<MCategory> category;

  MCategoryListResponse.named({
    required this.success,
    required this.category,
  });

  factory MCategoryListResponse(Map<String, dynamic> json) =>
      MCategoryListResponse.named(
        success: json["success"],
        category: List<MCategory>.from(
            json["Category"].map((x) => MCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Category": List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class MCategory implements CategoryFilterItemable {
  final String id;
  @override
  final String name;
  final String desc;
  final String image;
  final bool isDeleted;
  final DateTime createdAt;
  final int v;
  @override
  final isSelected = false.obs;
  MCategory({
    required this.id,
    required this.name,
    required this.desc,
    required this.image,
    required this.isDeleted,
    required this.createdAt,
    required this.v,
  });

  factory MCategory.fromJson(Map<String, dynamic> json) => MCategory(
        id: json["_id"],
        name: json["name"],
        desc: json["desc"],
        image: json["image"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "desc": desc,
        "image": image,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "__v": v,
      };
}
