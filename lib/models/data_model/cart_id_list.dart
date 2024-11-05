class MCartIdListResponse {
  final List<String> data;

  MCartIdListResponse.named({
    required this.data,
  });

  factory MCartIdListResponse(Map<String, dynamic> json) =>
      MCartIdListResponse.named(
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
