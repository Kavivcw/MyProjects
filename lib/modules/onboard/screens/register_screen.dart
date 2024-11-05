import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sparebess/modules/onboard/model/vm_register.dart';
import 'package:sparebess/modules/onboard/screens/login_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';

abstract class RegisterField {
  static const name = 'name';
  static const mobile = 'number';
  static const email = 'email';
  static const password = 'password';
}

abstract class RegisterDropdown {
  static const userType = 'user_type';
}

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final data = VMRegister();
  final form = FormGroup({
    RegisterField.name: FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
    RegisterField.mobile: FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(10),
    ]),
    // RegisterField.email: FormControl<String>(),
    RegisterField.password: FormControl<String>(validators: [
      Validators.required,
      Validators.minLength(6),
    ]),
    RegisterDropdown.userType: FormControl<String>(validators: [
      Validators.required,
    ]),
  });

  InputDecoration fieldDecoration({required String hintText}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0,
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appthemecolor1),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }

  final fieldGap = const Gap(20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: 'Register',
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: ReactiveForm(
                formGroup: form,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'logo_red'.png,
                        width: Get.width * 0.25,
                      ),
                      Gap(35),
                      Text(
                        'Register Now',
                        style: TextStyle(
                          fontSize: 20,
                          color: appthemecolor1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(35),
                      TextFieldTitleView(
                        title: 'User Name',
                        child: ReactiveTextField(
                          // keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[A-Za-z]'),
                            ),
                          ],
                          formControlName: RegisterField.name,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                'Enter your user name',
                          },
                          decoration:
                              fieldDecoration(hintText: 'Enter Your User Name'),
                        ),
                      ),
                      fieldGap,
                      TextFieldTitleView(
                        title: 'Mobile Number',
                        child: PhoneTextBox(controlName: RegisterField.mobile),
                      ),
                      fieldGap,
                      TextFieldTitleView(
                        title: 'Create Password',
                        child: ReactiveTextField(
                          formControlName: RegisterField.password,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                'Enter Your Password',
                            ValidationMessage.minLength: (_) =>
                                'Password should be greater than 5 digit',
                          },
                          decoration:
                              fieldDecoration(hintText: 'Enter Your Password'),
                        ),
                      ),
                      fieldGap,
                      TextFieldTitleView(
                        title: 'User type',
                        child: ReactiveDropdownField<String>(
                          formControlName: RegisterDropdown.userType,
                          validationMessages: {
                            ValidationMessage.required: (_) =>
                                'Select your user type',
                          },
                          items: ['customer', 'mechanic', 'retail']
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.capitalizeFirst ?? e),
                                  ))
                              .toList(),
                          decoration:
                              fieldDecoration(hintText: 'Select user type'),
                        ),
                      ),
                      Gap(35),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: 'Register',
                              state: data.loadingState,
                              onPressed: () {
                                if (form.valid) {
                                  data.scRegister(form.value);
                                } else {
                                  form.markAllAsTouched();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class TextFieldTitleView extends StatelessWidget {
  const TextFieldTitleView({
    super.key,
    required this.title,
    required this.child,
  });
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(10),
        child,
      ],
    );
  }
}
