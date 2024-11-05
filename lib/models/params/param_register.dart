import 'package:sparebess/models/params/paramable.dart';

class ParamRegister implements Encodable {
  String name;
  String number;
  String email;
  String userType;

  ParamRegister({
    required this.name,
    required this.number,
    required this.email,
    required this.userType,
  });

  // ParamRegister.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   number = json['number'];
  //   email = json['email'];
  //   userType = json['user_type'];
  // }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['number'] = number;
    data['email'] = email;
    data['user_type'] = userType;
    return data;
  }
}
