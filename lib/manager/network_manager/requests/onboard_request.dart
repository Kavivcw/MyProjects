import 'package:sparebess/models/data_model/m_user.dart';

import '../network_manager.dart';
import '../request.dart';

abstract class OnboardRequest {
  static Request<MLogin> login(Map<String, dynamic> param) {
final loginurl=param;
print("loginurl---------------");
print(loginurl);
    return Request(
      MLogin.new,
      endPoint: 'login',
      path: Path.user,
      method: Method.post,
      param: param,
    );
  }

  static Request<MDefault> register(Map<String, dynamic> param) {
    return Request(
      MDefault.new,
      endPoint: 'createuser',
      path: Path.user,
      method: Method.post,
      param: param,
    );
  }
}
