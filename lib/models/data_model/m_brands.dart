class MBrandListResponse {
  final bool success;
  final List<MBrand> marquee;

  MBrandListResponse.named({
    required this.success,
    required this.marquee,
  });

  factory MBrandListResponse(Map<String, dynamic> json) =>
      MBrandListResponse.named(
        success: json["success"],
        marquee:
            List<MBrand>.from(json["Marquee"].map((x) => MBrand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Marquee": List<dynamic>.from(marquee.map((x) => x.toJson())),
      };
}

class MBrand {
  final String id;
  final String name;
  final String image;
  final String sortTag;
  final bool isDeleted;
  final DateTime createdAt;
  final int v;

  MBrand({
    required this.id,
    required this.name,
    required this.image,
    required this.sortTag,
    required this.isDeleted,
    required this.createdAt,
    required this.v,
  });

  factory MBrand.fromJson(Map<String, dynamic> json) => MBrand(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        sortTag: json["sort_tag"],
        isDeleted: json["is_deleted"],
        createdAt: DateTime.parse(json["created_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
        "sort_tag": sortTag,
        "is_deleted": isDeleted,
        "created_at": createdAt.toIso8601String(),
        "__v": v,
      };
}
