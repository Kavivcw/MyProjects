import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sparebess/modules/onboard/model/vm_login.dart';
import 'package:sparebess/modules/onboard/screens/register_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_button.dart';

import '../../tab_bar_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final data = Get.put(VMLogin());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Image.asset(
                'logo_red'.png,
                width: Get.width * 0.25,
              ),
              const Gap(35),
              Text(
                'Enter Phone Number for Verification,',
                style: TextStyle(
                  fontSize: 20,
                  color: appthemecolor1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(35),
              Text(
                'This number will be used for all ride-related communication.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: appthemecolor1,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(35),
              ReactiveForm(
                formGroup: data.form,
                child: const PhoneTextBox(controlName: 'mobile'),
              ),
              const Gap(35),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: 'Login',
                      state: data.loadingState,
                      onPressed: () {
                        if (data.form.valid) {
                          data.scLogin();
                        } else {
                          data.form.markAllAsTouched();
                        }
                      },
                    ),
                  ),
                ],
              ),
              const Gap(25),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        fontSize: 18,
                        // color: appthemecolor1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const Gap(25),
              Text.rich(
                TextSpan(
                  children: [
                    const WidgetSpan(child: Text('New Customer?')),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: const Text(
                          '  Sign up',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SimpleElevatedButton(
                color: Colors.green,
                onPressed: () {
                  Get.offAll(() => TabBarScreen(), routeName: '/');
                },
                child: const Text('Skip Login',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),

             /* GestureDetector(
                onTap: () {
                  Get.offAll(() => TabBarScreen(), routeName: '/');
                },
                child:  Text(
                  'Skip Login',
                  style: TextStyle(
                    color: appthemecolor1,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

class SimpleElevatedButton extends StatelessWidget {
  const SimpleElevatedButton(
      {this.child,
        this.color,
        this.onPressed,
        this.borderRadius = 9,
        this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        Key? key})
      : super(key: key);
  final Color? color;
  final Widget? child;
  final Function? onPressed;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: padding, backgroundColor: appthemecolor2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed as void Function()?,
      child: child,
    );
  }
}
class PhoneTextBox extends StatelessWidget {
  const PhoneTextBox({super.key, required this.controlName, this.onChangeCode});
  final String controlName;
  final Function(CountryCode)? onChangeCode;
  InputDecoration get decoration {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15),
      hintText: 'Enter Phone Number',
      filled: true,
      fillColor: Colors.white,
      counterText: '',
      hintStyle: const TextStyle(color: Colors.grey),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      prefixIcon: CountryCodePicker(
        onChanged: onChangeCode,
        initialSelection: 'IN',
        favorite: const ['+91', 'IND'],
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
        alignLeft: false,

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      onTapOutside: hideKeyboard,
      formControlName: controlName,
      maxLength: 10,
      validationMessages: {
        ValidationMessage.required: (_) => 'Please Enter your mobile number',
        ValidationMessage.minLength: (_) => 'Mobile number should be 10 digit',
      },
      cursorColor: Colors.grey,
      keyboardType: TextInputType.phone,
      decoration: decoration,

    );
    // return ReactiveFormField(
    //   formControlName: controlName,
    //   builder: (state) {
    //     return TextFormField(
    //       cursorColor: Colors.grey,
    //       keyboardType: TextInputType.phone,
    //       decoration: decoration,
    //     );
    //   },
    // );
  }
}
