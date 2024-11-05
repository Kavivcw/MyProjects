import 'package:get/get.dart';

class MCartListResponse {
  final bool success;
  final List<MCartItem> products;

  MCartListResponse.named({
    required this.success,
    required this.products,
  });

  factory MCartListResponse(Map<String, dynamic> json) =>
      MCartListResponse.named(
        success: json["success"],
        products: List<MCartItem>.from(
            json["products"].map((x) => MCartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class MCartItem {
  final String id;
  final String productId;
  final String productName;
  final String partNumber;
  final String model;
  final String stock;
  final String sku;
  final double price;
  final String mrp;
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
  final double weight;
  final String weightClass;
  final String seoTitle;
  final String seoDescription;
  final String seoKeyword;
  final List<dynamic> sortBy;
  final List<String> images;
  final String totalrating;
  final bool stockStatus;
  final bool stockClearence;
  final int sales;
  final bool isDeleted;
  final List<dynamic> specifications;
  final List<dynamic> ratings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String cartUserUserId;
  final String cartProductProductId;
  final double cartPrice;
  final bool saveForLater;

  final cartCount = 1.obs;

  // updateCartCount(int count) {
  //   cartCount.value = min(10, max(1, count));
  // }

  double get subTotal {
    return cartCount.value * price;
  }

  double get totalWeight {
    return cartCount.value * weight;
  }

  MCartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.partNumber,
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
    required this.v,
    required this.cartUserUserId,
    required this.cartProductProductId,
    required int cartQuantity,
    required this.cartPrice,
    required this.saveForLater,
  }) {
    cartCount.value = cartQuantity;
  }

  factory MCartItem.fromJson(Map<String, dynamic> json) => MCartItem(
        id: json["_id"],
        productId: json["id"].toString(),
        productName: json["product_name"],
        partNumber: json["part_number"],
        model: json["model"],
        stock: json["stock"],
        sku: json["sku"],
        price: double.parse(json["price"].toString()),
        mrp: json["mrp"],
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
        weight: double.parse(json["weight"].toString()),
        weightClass: json["weight_class"],
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        seoKeyword: json["seo_keyword"],
        sortBy: List<dynamic>.from(json["sort_by"].map((x) => x)),
        images: List<String>.from(json["images"].map((x) => x)),
        totalrating: json["totalrating"],
        stockStatus: json["stock_status"],
        stockClearence: json["stock_clearence"],
        sales: json["sales"],
        isDeleted: json["is_deleted"],
        specifications:
            List<dynamic>.from(json["specifications"].map((x) => x)),
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        cartUserUserId: json["cart_user_user_Id"],
        cartProductProductId: json["cart_product_product_Id"],
        cartQuantity: int.parse(json["cart_quantity"]?.toString() ?? '0'),
        cartPrice: double.parse(json["cart_price"].toString()),
        saveForLater: json["save_for_later"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": productId,
        "product_name": productName,
        "part_number": partNumber,
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
        "__v": v,
        "cart_user_user_Id": cartUserUserId,
        "cart_product_product_Id": cartProductProductId,
        "cart_quantity": cartCount.value,
        "cart_price": cartPrice,
        "save_for_later": saveForLater,
      };
}
