import 'package:sparebess/shared/extensions.dart';

class MPrivacyResponse {
  final String? message;
  final List<MPrivacy> data;

  MPrivacyResponse.named({
    required this.message,
    required this.data,
  });

  factory MPrivacyResponse(Map<String, dynamic> json) => MPrivacyResponse.named(
        message: json["Message"],
        data:
            List<MPrivacy>.from(json["data"].map((x) => MPrivacy.fromJson(x))),
      );
}

class MPrivacy {
  String? content;

  MPrivacy({
    this.content,
  });

  MPrivacy.fromJson(Map<String, dynamic> json)
      : this(
          content: json.hasProp('content') ? json['content'] as String : null,
        );

  Map<String, dynamic> toJson() => {
        'content': content,
      };
}
