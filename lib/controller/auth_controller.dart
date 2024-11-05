import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/onboard_request.dart';
import 'package:sparebess/modules/onboard/screens/welcome_screen.dart';
import 'package:sparebess/modules/tab_bar_screen.dart';

import '../models/data_model/m_user.dart';
import '../modules/onboard/screens/login_screen.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  final isLogged = false.val('isLogged');
  final accessToken = "".val('accessToken');
  final userDict = <String, dynamic>{}.val('userString');
  final box = GetStorage();
  MUser? user;

  scLogin(Map<String, dynamic> param) async {
    final queryString = param;
    final url = 'OTP$queryString';
    print('API URLlll: $url');
    print('API URLlll2: $queryString');
    final response = await OnboardRequest.login(param).load();
    isLogged.val = true;
    accessToken.val = response.token;

    userDict.val = response.data.user.toJson();
    Get.offAll(() => TabBarScreen(), routeName: '/');
  }

  onLogin(MLogin response) async {
    print("otpresponse");
    print(response);
    print(response.data);
    print(response.message);
    print(response.token);
    print(response.data.user);
    isLogged.val = true;
    accessToken.val = response.token;
    userDict.val = response.data.user.toJson();
    Get.offAll(() => TabBarScreen(), routeName: '/');
  }

  logout() async {
    final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
    tokenprefs.clear();

    print(tokenprefs.getString('accessToken'));

    isLogged.val = false;
    accessToken.val = '';
    userDict.val = {};
    Get.offAll(() => LoginScreen());
  }

  updateUserObject(Map<String, dynamic> value) {
    try {
      user = MUser(value);
    } catch (e) {
      user = null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    updateUserObject(userDict.val);
    box.listenKey('userString', (value) {
      updateUserObject(value);
    });
  }
}
