import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/address_request.dart';
import 'package:sparebess/models/data_model/m_address.dart';
import 'package:sparebess/shared/constant.dart';

import '../../../../manager/network_manager/request.dart';
import '../../../../shared/theme.dart';

abstract class AddressField {
  static const country = 's_country';
  static const name = 's_fname';
  static const state = 's_state';
  static const city = 's_city';
  static const pincode = 's_pincode';
  static const address = 's_address';
  static const mobile = 's_number';
  static const defaultAddress = 'defaultAddress';

  static const fieldValues = [
    country,
    name,
    state,
    city,
    pincode,
    address,
    mobile
  ];
}



class VMReactiveField {
  final String placeholder;
  final TextInputType keyboardType;
  final int? maxLength;
  final Map<String, String Function(Object)>? validationMessages;

  VMReactiveField({
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.validationMessages,
  });
}

class VMAddAddress extends GetxController {
  late final FormGroup form;
  final isDefaultAddress = false.obs;
  final MShippingAddress? updateAddress;
  final loadingState = LoadingState(initialState: RxStatus.success());
  final fieldData = <String, VMReactiveField>{};
  final textRegex = RegExp(r'^[a-zA-Z ]+$');

  VMAddAddress({required this.updateAddress}) {
    form = FormGroup({
      AddressField.country: FormControl<String>(
        value: 'India',
          validators: [Validators.required,]),


      AddressField.name: FormControl<String>(
        value: updateAddress?.sFname,
        validators: [
          Validators.required,
          Validators.pattern(textRegex),
        ],
      ),
      AddressField.state: FormControl<String>(
        value: updateAddress?.sState?.toLowerCase(),
        validators: [
          Validators.required,


        ],
      ),
      AddressField.city: FormControl<String>(
        value: updateAddress?.sCity,
        validators: [
          Validators.required,
        ],
      ),
      AddressField.pincode: FormControl<String>(
        value: updateAddress?.sPincode,
        validators: [
          Validators.required,
          Validators.number(allowNegatives: false),
          Validators.minLength(6),
        ],
      ),
      AddressField.address: FormControl<String>(
        value: updateAddress?.sAddress,
        validators: [
          Validators.required,
        ],
      ),
      AddressField.mobile: FormControl<String>(
        value: updateAddress?.sNumber,
        validators: [
          Validators.required,
          Validators.minLength(10),
        ],
      ),
      AddressField.defaultAddress: FormControl<bool>(
        value: updateAddress?.defaultAddress,
      ),
    });


    fieldData[AddressField.country] = VMReactiveField(
      placeholder: 'Country',
      validationMessages: {
        ValidationMessage.required: (_) => 'Enter your country',
        ValidationMessage.pattern: (_) => 'Enter a valid country',
      },
    );
    fieldData[AddressField.name] = VMReactiveField(
      placeholder: 'Full Name',
      validationMessages: {
        ValidationMessage.required: (_) => 'Enter your Full Name',
        ValidationMessage.pattern: (_) => 'Enter a valid Name',
      },
    );

    fieldData[AddressField.address] = VMReactiveField(
      placeholder: 'Flat, House no, Building, Company',
      validationMessages: {
        ValidationMessage.required: (_) => 'Enter your Address',
      },
    );

    fieldData[AddressField.city] = VMReactiveField(
      placeholder: 'Town / City',
      validationMessages: {
        ValidationMessage.required: (_) => 'Enter your Town / City',
      },
    );

    fieldData[AddressField.pincode] = VMReactiveField(
      placeholder: 'Pincode',
      keyboardType: TextInputType.number,
      maxLength: 6,
      validationMessages: {
        ValidationMessage.required: (_) => 'Pincode is required',
        ValidationMessage.number: (_) => 'Enter a valid Zipcode',
        ValidationMessage.minLength: (_) => 'Enter a valid Zipcode',
      },
    );

    fieldData[AddressField.state] = VMReactiveField(
      placeholder: 'State',
      validationMessages: {
        ValidationMessage.required: (_) => 'Enter your State',
        ValidationMessage.pattern: (_) => 'Enter a valid State',
      },
    );

    fieldData[AddressField.mobile] = VMReactiveField(
      placeholder: 'Mobile Number',
    );
  }

  scAddAddress() async {
    try {
      stopInteraction();
      loadingState.value = RxStatus.loading();
      final param = form.value;
      final Request<MDefault> request;
      if (updateAddress != null) {
        request = AddressRequest.updateAddress(updateAddress!.id, param);
      } else {
        request = AddressRequest.addAddress(param);
      }
      final response = await Network.shared.load(request);
      Get.back(result: response.success);
    } catch (e) {
      showToast(e);
    } finally {
      loadingState.value = RxStatus.success();
      allowInteraction();
    }
  }
}
