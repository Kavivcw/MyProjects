import 'package:sparebess/shared/extensions.dart';

class MCancellationPolicyResponse {
  final String? message;
  final List<MCancellationPolicy> data;

  MCancellationPolicyResponse.named({
    required this.message,
    required this.data,
  });

  factory MCancellationPolicyResponse(Map<String, dynamic> json) =>
      MCancellationPolicyResponse.named(
        message: json["Message"],
        data: List<MCancellationPolicy>.from(
            json["data"].map((x) => MCancellationPolicy.fromJson(x))),
      );
}

class MCancellationPolicy {
  String? content;

  MCancellationPolicy({
    this.content,
  });

  MCancellationPolicy.fromJson(Map<String, dynamic> json)
      : this(
          content: json.hasProp('content') ? json['content'] as String : null,
        );

  Map<String, dynamic> toJson() => {
        'content': content,
      };
}
