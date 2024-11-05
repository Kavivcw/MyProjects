import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/onboard_request.dart';
import 'package:sparebess/shared/constant.dart';

class VMRegister {
  final loadingState = LoadingState(initialState: RxStatus.success());
  scRegister(Map<String, dynamic> param) async {
    final finalParam = <String, dynamic>{'email': ''};

    finalParam.addAll(param);
    try {
      final response = await OnboardRequest.register(finalParam)
          .load(state: loadingState, interaction: false);
      Get.back();
      showToast(response.message);
    } catch (e) {
      showToast(e);
    }
  }
}
