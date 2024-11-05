import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/address_request.dart';
import 'package:sparebess/models/data_model/m_address.dart';
import 'package:sparebess/shared/constant.dart';

import '../modules/user/address/add_address/add_address_screen.dart';

class AddressController extends GetxController {
  static AddressController get to => Get.find();
  final selectedAddress = Rxn<MShippingAddress>();
  final addresses = Rxn<MAddress>(null);
  final loadingState = LoadingState();

  Future<void> scAddressList() async {
    addresses.value = null;
    final response =
        await AddressRequest.addressList().load(state: loadingState);
    addresses.value = response.address;
    final validAddresses = response.address.shippingAddress
        .where((element) => !element.isDefaultData)
        .toList();
    selectedAddress.value =
        validAddresses.firstWhereOrNull((element) => element.defaultAddress) ??
            validAddresses.firstOrNull;
    loadingState.updateSuccess(validAddresses.isNotEmpty);
  }

  navigateToAddAddress({MShippingAddress? updateAddress}) async {
    final bool? isRefresh =
        await Get.to(() => AddAddressScreen(updateAddress: updateAddress));
    if (isRefresh ?? false) {
      scAddressList();
    }
  }

  Future<void> deleteAddress(MShippingAddress address) async {
    final response = await AddressRequest.delete(address.id).load();
    scAddressList();
  }

  scMakeDefault(String id) async {
    try {
      final response = await AddressRequest.makeDefault(id).load();
      scAddressList();
    } catch (e) {
      showToast(e);
    }
  }
}
