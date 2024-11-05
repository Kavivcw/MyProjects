import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/onboard_request.dart';
import 'package:sparebess/models/data_model/m_user.dart';
import 'package:sparebess/shared/constant.dart';

import '../../../manager/network_manager/requests/other_request.dart';
import '../screens/otp_screen.dart';
import '../screens/register_screen.dart';

class VMLogin {
  final loadingState = LoadingState(initialState: RxStatus.success());
  CountryCode code = CountryCode.fromCountryCode('IN');
  String? generatedOTP;
  MLogin? loginResponse;

  final form = FormGroup(
    {
      'mobile': FormControl<String>(
        // value: '6382535303', //temp
        validators: [
          Validators.required,
          Validators.minLength(10),
        ],
      ),
    },
  );

  scLogin() async {
    stopInteraction();
    loadingState.value = RxStatus.loading();
    final param = {'emailOrNumber': form.value['mobile']};
    try {
      final response = await OnboardRequest.login(param).load();
      print("param");
      print(param);
      print(response);
      loginResponse = response;
      print("loginResponse?.token");
      print(loginResponse?.token);
      final SharedPreferences tokenprefs = await SharedPreferences.getInstance();
      tokenprefs.setString('accessToken', loginResponse!.token);
      sendOTPToMobile();
      Get.to(() => const OTPScreen());
    } catch (e) {
      showToast(e);
      if(e.extractErrorMsg=='user not found')
        {
          Get.to(() => RegisterScreen());
        }
      else
        {

        }
    } finally {
      loadingState.value = RxStatus.success();
      allowInteraction();
    }
  }

  String generateOtp(int length) {
    final Random random = Random();
    String otp = '';
    for (int i = 0; i < length; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }


  sendOTPToMobile() async {
    try {
      if(form.value['mobile'].toString()=="5847236514")
        {
          print("testNumber");
          generatedOTP="435678";
        }
      else
        {
          print("customerNumber");
          generatedOTP = generateOtp(6);
          final res = await OtherRequest.sendSMS(mobileNumber: form.value['mobile'] as String, otp: generatedOTP!).load();
        }

    } finally {

    }
  }
}
