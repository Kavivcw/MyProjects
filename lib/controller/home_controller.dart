import 'package:get/get.dart';

final class HomeController extends GetxController {
  static HomeController get to => Get.find();
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int value) {
    _tabIndex = value;
    update();
  }
}
