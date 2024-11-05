import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sparebess/models/data_model/m_address.dart';
import 'package:sparebess/modules/onboard/screens/login_screen.dart';
import 'package:sparebess/modules/user/address/add_address/vm_add_address.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';

import '../../../../shared/theme.dart';
import '../../../onboard/screens/register_screen.dart';

class AddAddressScreen extends StatelessWidget {
  late final VMAddAddress data;

  AddAddressScreen({super.key, MShippingAddress? updateAddress}) {
    data = Get.put(VMAddAddress(updateAddress: updateAddress));
  }

  bool get isUpdate {
    return data.updateAddress != null;
  }

  InputDecoration decoration(VMReactiveField fieldData) {
    return InputDecoration(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appthemecolor1),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appthemecolor1),
      ),
      hintText: fieldData.placeholder,
      border: const OutlineInputBorder(),
    );
  }

  String get title {
    return isUpdate ? 'Update Address' : 'Add Address';
  }
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: title,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: ReactiveForm(
                formGroup: data.form,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: hSpace),
                  child: Column(
                    children: [

                      Gap(15),
                      ...AddressField.fieldValues.map(
                        (e) {
                          final fieldData = data.fieldData[e]!;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: e == AddressField.mobile
                                ? PhoneTextBox(controlName: e)
                                :e == AddressField.country?
                            ReactiveDropdownField<String>(
                              formControlName: e,
                              decoration: decoration(fieldData),
                              items: [
                                'America',
                                'Australia',
                                'Afghanistan',
                                'China',
                                'Canada',
                                'France',
                                'Germany',
                                'Haiti',
                                'India',
                                'Japan',
                                'Malaysia',
                                'Mexico',
                                'Pakistan',
                                'Russia',
                                'Sri Lanka',
                                'South Africa',
                                'Singapore',
                                'Saudi Arabia',
                                'Thailand',
                                'United Kingdom',
                                'Zimbabwe'].map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.capitalizeFirst ?? e),
                              ))
                                  .toList(),

                            ):e == AddressField.state?
                            ReactiveDropdownField<String>(
                              formControlName: e,
                              decoration: decoration(fieldData),
                              items: [
                                'Andhra Pradesh',
                                'Arunachal Pradesh',
                                'Assam',
                                'Bihar',
                                'Chhattisgarh',
                                'Goa',
                                'Gujarat',
                                'Haryana',
                                'Himachal Pradesh',
                                'Jharkhand',
                                'Karnataka',
                                'Kerala',
                                'Madhya Pradesh',
                                'Maharashtra',
                                'Manipur',
                                'Meghalaya',
                                'Mizoram',
                                'Nagaland',
                                'Odisha',
                                'Punjab',
                                'Pondicherry',
                                'Rajasthan',
                                'Sikkim',
                                'Tamilnadu',
                                'Telangana',
                                'Tripura',
                                'Uttarakhand',
                                'Uttar Pradesh',
                                'West Bengal',
                              ].map((e) => DropdownMenuItem(
                                value: e.camelCase,
                                child: Text(e.capitalizeFirst ?? e),
                              ))
                                  .toList(),

                            ):
                            ReactiveTextField(
                                    formControlName: e,
                                    decoration: decoration(fieldData),
                                    onTapOutside: hideKeyboard,
                                    keyboardType: fieldData.keyboardType,
                                    maxLength: fieldData.maxLength,
                                    validationMessages:
                                        fieldData.validationMessages,
                                  ),
                          );
                        },
                      ),
                     /* Row(
                        children: [
                          ReactiveCheckbox(
                            formControlName: AddressField.defaultAddress,
                            activeColor: appthemecolor1,
                            side: BorderSide(color: appthemecolor1, width: 2),
                            // overlayColor: MaterialStateProperty.all(Colors.white),
                            // fillColor: MaterialStateProperty.all(Colors.white),
                            // fillColor: MaterialStateProperty.all(appthemecolor1),
                            // overlayColor: MaterialStateProperty.all(Colors.white),
                          ),
                          Expanded(child: Text('Make this address as default')),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: hSpace),
              child: AppButton(
                title: title,
                state: data.loadingState,
                onPressed: () {
                  if (data.form.valid) {
                    data.scAddAddress();
                  } else {
                    data.form.markAllAsTouched();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
