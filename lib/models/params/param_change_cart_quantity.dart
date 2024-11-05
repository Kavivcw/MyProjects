import 'package:sparebess/models/params/paramable.dart';

enum ECartOperation {
  plus,
  minus;
}

class ParamChangeCartQuantity implements Encodable {
  final String id;
  final ECartOperation operation;

  ParamChangeCartQuantity({
    required this.id,
    required this.operation,
  });

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "operation": operation.name,
      };
}
