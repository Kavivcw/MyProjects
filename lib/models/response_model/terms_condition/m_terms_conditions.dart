import 'package:sparebess/shared/extensions.dart';

class MTermsConditionResponse {
  final String? message;
  final List<MTermsConditions> data;

  MTermsConditionResponse.named({
    required this.message,
    required this.data,
  });

  factory MTermsConditionResponse(Map<String, dynamic> json) =>
      MTermsConditionResponse.named(
        message: json["Message"],
        data: List<MTermsConditions>.from(
            json["data"].map((x) => MTermsConditions.fromJson(x))),
      );
}

class MTermsConditions {
  String? content;

  MTermsConditions({
    this.content,
  });

  MTermsConditions.fromJson(Map<String, dynamic> json)
      : this(
          content: json.hasProp('content') ? json['content'] as String : null,
        );

  Map<String, dynamic> toJson() => {
        'content': content,
      };
}
