import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/auth_controller.dart';
import 'package:sparebess/modules/onboard/model/vm_login.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_button.dart';

import '../../../views/app_bar/default_app_bar.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final loginData = Get.find<VMLogin>();
  var enteredOTP = '';

  @override
  void initState() {
    super.initState();
    // enteredOTP = loginData.generatedOTP ?? ''; //temp
  }

  TextStyle createOTPTextStyle() {
    return TextStyle(
      fontSize: 24,
      color: appthemecolor1,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(title: 'Verification'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'logo_red'.png,
              width: Get.width * 0.25,
            ),
            // Text('OTP: $otp'),
            Gap(35),
            Text(
              'Please enter the OTP sent to your\nmobile number ${loginData.code.dialCode} ${loginData.form.value['mobile']}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: appthemecolor1,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(35),
            OtpTextField(
              // contentPadding: EdgeInsets.zero,
              // margin: EdgeInsets.symmetric(horizontal: 10),
              numberOfFields: 6,
              borderColor: Colors.grey,
              focusedBorderColor: appthemecolor1,
              styles: List.generate(6, (index) => createOTPTextStyle()),
              showFieldAsBox: false,
              borderWidth: 2.0,
              //runs when a code is typed in
              onCodeChanged: (String code) {

                //handle validation or checks here if necessary
              },
              //runs when every textfield is filled
              onSubmit: (String verificationCode) {
                enteredOTP = verificationCode;
              },
              // fieldWidth: (Get.width - 30 - 120) / 6,
              fieldWidth: 48,
            ),
            const Gap(35),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Continue'.toUpperCase(),
                    fontSize: 16,
                    state: loginData.loadingState,
                    onPressed: () async {
                      if (loginData.generatedOTP == enteredOTP) {
                         AuthController.to.onLogin(loginData.loginResponse!);
                      } else {
                        showToast('Enter valid otp');
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
