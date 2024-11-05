class MShippingFeeResponse {
  final String message;
  final List<MShippingFee> data;

  MShippingFeeResponse.named({
    required this.message,
    required this.data,
  });

  factory MShippingFeeResponse(Map<String, dynamic> json) =>
      MShippingFeeResponse.named(
        message: json["Message"],
        data: List<MShippingFee>.from(
            json["data"].map((x) => MShippingFee.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MShippingFee {
  final double initialPrice;

  MShippingFee({
    required this.initialPrice,
  });

  factory MShippingFee.fromJson(Map<String, dynamic> json) => MShippingFee(
        initialPrice: double.parse(json["initialPrice"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "initialPrice": initialPrice,
      };
}
