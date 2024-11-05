import 'dart:ffi';

class RelatedProduct {
  RelatedProduct({
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
    required this.isDeleted,
    required this.specifications,
    required this.ratings,
    required this.createdAt,
    required this.updatedAt,

  });
  late  String id;
  late  String productName;
  late  String partNumber;
  late  String keyword;
  late  String model;
  late  String stock;
  late  String sku;
  late  double price;
  late  String mrp;
  late  String tax;
  late  String sortOrder;
  late  String manufacture;
  late  String category;
  late  String variant;
  late  String rewardPoints;
  late  String year;
  late  String condition;
  late  String warranty;
  late  String crossSelling;
  late  String techSpecification;
  late  String description;
  late  String length;
  late  String height;
  late  String breadth;
  late  String dimensionClass;
  late  String weight;
  late  String weightClass;
  late  String seoTitle;
  late  String seoDescription;
  late  String seoKeyword;
  late  List<dynamic> sortBy;
  late  List<String> images;
  late  double totalrating;
  late  bool stockStatus;
  late  bool stockClearence;

  late  bool isDeleted;
  late  List<dynamic> specifications;
  late  List<dynamic> ratings;
  late  String createdAt;
  late  String updatedAt;


  RelatedProduct.fromJson(Map<String, dynamic> json){
    id = json['_id']??"";
    productName = json['product_name']??"";
    partNumber = json['part_number']??"";
    keyword = json['keyword']??"";
    model = json['model']??"";
    stock = json['stock']??"";
    sku = json['sku']??"";
    price = (json['price'] is int ? (json['price'] as int).toDouble() : json['price'] as double);
    mrp = json['mrp']??"";
    tax = json['tax']??"";
    sortOrder = json['sort_order']??"";
    manufacture = json['manufacture']??"";
    category = json['category']??"";
    variant = json['variant']??"";
    rewardPoints = json['reward_points']??"";
    year = json['year']??"";
    condition = json['condition']??"";
    warranty = json['warranty']??"";
    crossSelling = json['cross_selling']??"";
    techSpecification = json['tech_specification']??"";
    description = json['description']??"";
    length = json['length']??"";
    height = json['height']??"";
    breadth = json['breadth']??"";
    dimensionClass = json['dimension_class']??"";
    weight = json['weight']??"";
    weightClass = json['weight_class']??"";
    seoTitle = json['seo_title']??"";
    seoDescription = json['seo_description']??"";
    seoKeyword = json['seo_keyword']??"";
    sortBy = List.castFrom<dynamic, dynamic>(json['sort_by']);
    images = List.castFrom<dynamic, String>(json['images']);
    totalrating: double.parse(json["totalrating"].toString());
    stockStatus = json['stock_status']??"";
    stockClearence = json['stock_clearence']??"";

    isDeleted = json['is_deleted']??"";
    specifications = List.castFrom<dynamic, dynamic>(json['specifications']);
    ratings = List.castFrom<dynamic, dynamic>(json['ratings']);
    createdAt = json['createdAt']??"";
    updatedAt = json['updatedAt']??"";

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['product_name'] = productName;
    _data['part_number'] = partNumber;
    _data['keyword'] = keyword;
    _data['model'] = model;
    _data['stock'] = stock;
    _data['sku'] = sku;
    _data['price'] = price;
    _data['mrp'] = mrp;
    _data['tax'] = tax;
    _data['sort_order'] = sortOrder;
    _data['manufacture'] = manufacture;
    _data['category'] = category;
    _data['variant'] = variant;
    _data['reward_points'] = rewardPoints;
    _data['year'] = year;
    _data['condition'] = condition;
    _data['warranty'] = warranty;
    _data['cross_selling'] = crossSelling;
    _data['tech_specification'] = techSpecification;
    _data['description'] = description;
    _data['length'] = length;
    _data['height'] = height;
    _data['breadth'] = breadth;
    _data['dimension_class'] = dimensionClass;
    _data['weight'] = weight;
    _data['weight_class'] = weightClass;
    _data['seo_title'] = seoTitle;
    _data['seo_description'] = seoDescription;
    _data['seo_keyword'] = seoKeyword;
    _data['sort_by'] = sortBy;
    _data['images'] = images;
    _data['totalrating'] = totalrating;
    _data['stock_status'] = stockStatus;
    _data['stock_clearence'] = stockClearence;
    _data['is_deleted'] = isDeleted;
    _data['specifications'] = specifications;
    _data['ratings'] = ratings;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;

    return _data;
  }
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
