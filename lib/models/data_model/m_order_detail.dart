class MOrderDetailResponse {
  final List<MOrderDetail> data;

  MOrderDetailResponse.named({
    required this.data,
  });

  factory MOrderDetailResponse(Map<String, dynamic> json) =>
      MOrderDetailResponse.named(
        data: List<MOrderDetail>.from(
            json["data"].map((x) => MOrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MOrderDetail {
  final String id;
  final String orderId;
  final String orderNumber;
  final String customerName;
  final String customerNumber;
  final MOrderProductDetail? productId;
  final String partNumber;
  final String orderProductName;
  final String orderItemAmount;
  final String orderItemQty;
  final String orderTotalAmount;
  final String orderCgstPercent;
  final String orderCgstValue;
  final String orderSgstPercent;
  final String orderSgstValue;
  final String orderIgstPercent;
  final String orderIgstValue;
  final String orderTotalGst;
  final String datumReturn;
  final String returnId;
  final bool isDeleted;
  final DateTime datumCreatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  MOrderDetail({
    required this.id,
    required this.orderId,
    required this.orderNumber,
    required this.customerName,
    required this.customerNumber,
    required this.productId,
    required this.partNumber,
    required this.orderProductName,
    required this.orderItemAmount,
    required this.orderItemQty,
    required this.orderTotalAmount,
    required this.orderCgstPercent,
    required this.orderCgstValue,
    required this.orderSgstPercent,
    required this.orderSgstValue,
    required this.orderIgstPercent,
    required this.orderIgstValue,
    required this.orderTotalGst,
    required this.datumReturn,
    required this.returnId,
    required this.isDeleted,
    required this.datumCreatedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MOrderDetail.fromJson(Map<String, dynamic> json) => MOrderDetail(
        id: json["_id"],
        orderId: json["order_id"],
        orderNumber: json["orderNumber"],
        customerName: json["customerName"],
        customerNumber: json["customerNumber"],
        productId: json["product_id"] != null
            ? MOrderProductDetail.fromJson(json["product_id"])
            : null,
        partNumber: json["part_number"],
        orderProductName: json["order_product_name"],
        orderItemAmount: json["order_item_amount"],
        orderItemQty: json["order_item_qty"],
        orderTotalAmount: json["order_total_amount"],
        orderCgstPercent: json["order_cgst_percent"],
        orderCgstValue: json["order_cgst_value"],
        orderSgstPercent: json["order_sgst_percent"],
        orderSgstValue: json["order_sgst_value"],
        orderIgstPercent: json["order_igst_percent"],
        orderIgstValue: json["order_igst_value"],
        orderTotalGst: json["order_total_gst"],
        datumReturn: json["return"],
        returnId: json["returnId"],
        isDeleted: json["is_deleted"],
        datumCreatedAt: DateTime.parse(json["created_at"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_id": orderId,
        "orderNumber": orderNumber,
        "customerName": customerName,
        "customerNumber": customerNumber,
        "product_id": productId?.toJson(),
        "part_number": partNumber,
        "order_product_name": orderProductName,
        "order_item_amount": orderItemAmount,
        "order_item_qty": orderItemQty,
        "order_total_amount": orderTotalAmount,
        "order_cgst_percent": orderCgstPercent,
        "order_cgst_value": orderCgstValue,
        "order_sgst_percent": orderSgstPercent,
        "order_sgst_value": orderSgstValue,
        "order_igst_percent": orderIgstPercent,
        "order_igst_value": orderIgstValue,
        "order_total_gst": orderTotalGst,
        "return": datumReturn,
        "returnId": returnId,
        "is_deleted": isDeleted,
        "created_at": datumCreatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class MOrderProductDetail {
  final String id;
  final int productIdId;
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
  final String weight;
  final String weightClass;
  final String seoTitle;
  final String seoDescription;
  final String seoKeyword;
  final List<dynamic> sortBy;
  final List<dynamic> images;
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

  MOrderProductDetail({
    required this.id,
    required this.productIdId,
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
  });

  factory MOrderProductDetail.fromJson(Map<String, dynamic> json) =>
      MOrderProductDetail(
        id: json["_id"],
        productIdId: json["id"],
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
        weight: json["weight"],
        weightClass: json["weight_class"],
        seoTitle: json["seo_title"],
        seoDescription: json["seo_description"],
        seoKeyword: json["seo_keyword"],
        sortBy: List<dynamic>.from(json["sort_by"].map((x) => x)),
        images: List<dynamic>.from(json["images"].map((x) => x)),
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": productIdId,
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
      };
}
