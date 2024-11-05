class MBannerResponse {
  final List<MBanner> data;

  MBannerResponse.named({
    required this.data,
  });

  factory MBannerResponse(Map<String, dynamic> json) => MBannerResponse.named(
        data: List<MBanner>.from(json["data"].map((x) => MBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<MBanner>.from(data.map((x) => x)),
      };
}

class MBanner {
  String imageURL;

  MBanner({
    required this.imageURL,
  });

  MBanner.fromJson(Map<String, dynamic> json)
      : this(
          imageURL: json['img_url'] ?? "",
        );

  Map<String, dynamic> toJson() => {
        'img_url': imageURL,
      };
}
