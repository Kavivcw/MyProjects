import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sparebess/controller/auth_controller.dart';
import 'package:sparebess/shared/constant.dart';

import 'controller/payment_controller.dart';
import 'modules/onboard/screens/login_screen.dart';
import 'modules/onboard/screens/welcome_screen.dart';
import 'modules/tab_bar_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  Get.put(AuthController(), permanent: true);
  Get.put(PaymentController(), permanent: true);
  runApp(const RootScreen());
  FlutterNativeSplash.remove();
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowCheckedModeBanner: false,Get.to(() => LoginScreen());
      home: AuthController.to.isLogged.val ? TabBarScreen() : LoginScreen(),
      // home: PaymentView(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Amazon Ember',
      ),
    );
  }
}
