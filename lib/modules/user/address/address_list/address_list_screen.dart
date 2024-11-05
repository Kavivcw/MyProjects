import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/controller/address_controller.dart';
import 'package:sparebess/models/data_model/m_address.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';

import '../../../../views/app_button.dart';
import '../../../order/checkout/checkout_screen.dart';

class AddressListScreen extends StatelessWidget {
  AddressListScreen({super.key, this.forPurchase = false});

  final bool forPurchase;
  final addressData = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        title: forPurchase ? 'Select Address' : 'Manage Address',
      ),
      body: GetX<AddressController>(
          initState: (_) => addressData.scAddressList(),
          builder: (controller) {
            final addressList =
                addressData.addresses.value?.shippingAddress ?? [];
            return SafeArea(
              child: Column(
                children: [
                  const Gap(15),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ElevatedButton(
                            onPressed: () => addressData.navigateToAddAddress(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: appthemecolor1, width: 1.0),
                              ),
                            ),
                            child: const Text(
                              "Add New Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontFamily: "Amazon Ember"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: RxStatusView1(
                      state: controller.loadingState,
                      shimmerHeight: 180,
                      // loader: Text('Loading'),
                      child: () => ListView.separated(
                        itemBuilder: (con, index) {
                          final address = addressList[index];
                          if (address.isDefaultData) {
                            return const SizedBox();
                          } else {
                            return AddressItemView(
                              data: address,
                              needSelectionIndicator: forPurchase,
                            );
                          }
                        },
                        separatorBuilder: (con, index) {
                          return const Gap(15);
                        },
                        itemCount: addressList.length,
                        padding: const EdgeInsets.all(hSpace),
                      ),
                    ),
                  ),
                  if (forPurchase)
                    Padding(
                      padding: const EdgeInsets.all(15)
                          .copyWith(bottom: safeBottomIfNeed()),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: forPurchase ? 'Continue' : 'Save Changes',
                              onPressed: () {
                                if (forPurchase) {
                                  if (addressData.selectedAddress.value !=
                                      null) {
                                    Get.to(() => CheckoutScreen());
                                  } else {
                                    showToast('Select the deliver address');
                                  }
                                } else {
                                  Get.back();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}

class AddressItemView extends StatelessWidget {
  AddressItemView({
    super.key,
    required this.data,
    required this.needSelectionIndicator,
    this.needAction = true,
  });

  final bool needSelectionIndicator;
  final bool needAction;
  final MShippingAddress data;
  final addressData = AddressController.to;

  Widget addressText() {
    return Padding(
      padding: EdgeInsets.all(needSelectionIndicator ? 0 : 15.0),
      child: Text.rich(
        TextSpan(
          text: '${data.sFname ?? ''}\n',
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text:
                  '${data.sAddress ?? ''},\n${data.sCity ?? ''}, ${data.sState ?? ''},\n${data.sCountry ?? ''}, ${data.sPincode ?? ''},\n${data.sNumber}',
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = addressData.selectedAddress.value;
      return Container(
        decoration: BoxDecoration(
          color: (selected?.id == data.id)
              ? appthemecolor1.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: data.defaultAddress
                  ? Colors.red.shade100
                  : Colors.black.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: needSelectionIndicator
                      ? RadioListTile(
                          title: addressText(),
                          value: data.id,
                          // contentPadding: EdgeInsets.only(left: 10),
                          groupValue: selected?.id,
                          activeColor: appthemecolor1,
                          overlayColor:
                              MaterialStateProperty.all(appthemecolor1),
                          fillColor: MaterialStateProperty.all(appthemecolor1),
                          onChanged: (value) {
                            addressData.selectedAddress.value = data;


                          },
                          // activeColor: appthemecolor1,
                        )
                      : addressText(),
                ),
              ],
            ),
            Divider(
              height: 1,
              thickness: 0.5,
            ),
            if (needAction)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 /* TextButton(
                    onPressed: () => addressData.scMakeDefault(data.id),
                    child: Text(
                      data.defaultAddress
                          ? 'This is default'
                          : 'Make as default',
                      style: TextStyle(
                        color: appthemecolor1,
                      ),
                    ),
                  ),*/
                  Spacer(),
                  IconButton(
                    onPressed: () =>
                        addressData.navigateToAddAddress(updateAddress: data),
                    icon: Icon(Icons.edit, color: appthemecolor1, size: 22.0),
                  ),
                  IconButton(
                    onPressed: () => addressData.deleteAddress(data),
                    icon: Icon(Icons.delete_forever_outlined,
                        color: appthemecolor1, size: 22.0),
                  ),
                ],
              )
          ],
        ),
      );
    });
  }
}
