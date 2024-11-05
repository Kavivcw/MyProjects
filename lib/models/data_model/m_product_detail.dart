class MProductDetailResponse {
  final String message;
  final List<MProductDetail> products;

  MProductDetailResponse.named({
    required this.message,
    required this.products,
  });

  factory MProductDetailResponse(Map<String, dynamic> json) =>
      MProductDetailResponse.named(
        message: json["Message"],
        products: List<MProductDetail>.from(
            json["products"].map((x) => MProductDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class MProductDetail {
  final String id;
  final String productName;
  final String partNumber;
  final String keyword;
  final String model;
  final String stock;
  final String sku;
  final double price;
  final double mrp;
  final String tax;
  final String sortOrder;
  final String manufacture;
  final String category;
  final String variant;
  final String rewardPoints;
  final String year;
  final String condition;
  final String warranty;
  final String crossSelling;
  final String techSpecification;
  final String description;
  final String length;
  final String height;
  final String breadth;
  final String dimensionClass;
  final String weight;
  final String weightClass;
  final String seoTitle;
  final String seoDescription;
  final String seoKeyword;
  final List<dynamic> sortBy;
  final List<String> images;
  final double totalrating;
  final bool stockStatus;
  final bool stockClearence;
  final int sales;
  final bool isDeleted;
  final List<dynamic> specifications;
  final List<dynamic> ratings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productId;
  final int v;

  MProductDetail({
    required this.id,
    required this.productName,
    required this.partNumber,
    required this.keyword,
    required this.model,
    required this.stock,
    required this.sku,
    required this.price,
    required this.mrp,
    required this.tax,
    required this.sortOrder,
    required this.manufacture,
    required this.category,
    required this.variant,
    required this.rewardPoints,
    required this.year,
    required this.condition,
    required this.warranty,
    required this.crossSelling,
    required this.techSpecification,
    required this.description,
    required this.length,
    required this.height,
    required this.breadth,
    required this.dimensionClass,
    required this.weight,
    required this.weightClass,
    required this.seoTitle,
    required this.seoDescription,
    required this.seoKeyword,
    required this.sortBy,
    required this.images,
    required this.totalrating,
    required this.stockStatus,
    required this.stockClearence,
    required this.sales,
    required this.isDeleted,
    required this.specifications,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.v,
  });

  factory MProductDetail.fromJson(Map<String, dynamic> json) => MProductDetail(
        id: json["_id"],
        productName: json["product_name"],
        partNumber: json["part_number"],
        keyword: json["keyword"],
        model: json["model"],
        stock: json["stock"],
        sku: json["sku"],
        price: double.parse(json["price"].toString()),
        mrp: double.parse(json["mrp"].toString()),
        tax: json["tax"],
        sortOrder: json["sort_order"],
        manufacture: json["manufacture"],
        category: json["category"],
        variant: json["variant"],
        rewardPoints: json["reward_points"],
        year: json["year"],
        condition: json["condition"],
        warranty: json["warranty"],
        crossSelling: json["cross_selling"],
        techSpecification: json["tech_specification"],
        description: json["description"],
        length: json["length"],
        height: json["height"],
        breadth: json["breadth"],
        dimensionClass: json["dimension_class"],
        weight: json["weight"],
        weightClass: json["weight_class"],
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        seoKeyword: json["seo_keyword"],
        sortBy: List<dynamic>.from(json["sort_by"].map((x) => x)),
        images: List<String>.from((json["images"] ?? []).map((x) => x)),
        totalrating: double.parse(json["totalrating"].toString()),
        stockStatus: json["stock_status"],
        stockClearence: json["stock_clearence"],
        sales: json["sales"],
        isDeleted: json["is_deleted"],
        specifications:
            List<dynamic>.from(json["specifications"].map((x) => x)),
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        productId: json["id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_name": productName,
        "part_number": partNumber,
        "keyword": keyword,
        "model": model,
        "stock": stock,
        "sku": sku,
        "price": price,
        "mrp": mrp,
        "tax": tax,
        "sort_order": sortOrder,
        "manufacture": manufacture,
        "category": category,
        "variant": variant,
        "reward_points": rewardPoints,
        "year": year,
        "condition": condition,
        "warranty": warranty,
        "cross_selling": crossSelling,
        "tech_specification": techSpecification,
        "description": description,
        "length": length,
        "height": height,
        "breadth": breadth,
        "dimension_class": dimensionClass,
        "weight": weight,
        "weight_class": weightClass,
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "seo_keyword": seoKeyword,
        "sort_by": List<dynamic>.from(sortBy.map((x) => x)),
        "images": List<dynamic>.from(images.map((x) => x)),
        "totalrating": totalrating,
        "stock_status": stockStatus,
        "stock_clearence": stockClearence,
        "sales": sales,
        "is_deleted": isDeleted,
        "specifications": List<dynamic>.from(specifications.map((x) => x)),
        "ratings": List<dynamic>.from(ratings.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": productId,
        "__v": v,
      };
}
