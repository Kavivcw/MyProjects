import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparebess/modules/order/payment/vm_payment.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';

import '../../../shared/theme.dart';

class PaymentScreen extends StatefulWidget {
  final data = Get.put(VMPayment());

  PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Payment',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(hSpace)
              .copyWith(bottom: safeBottomIfNeed(value: 10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Payborder,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemBuilder: (con, index) {
                    return PaymentTypeItemView(
                        data: widget.data.arrPaymentTypes[index],
                        selected: widget.data.paymentType);
                  },
                  itemCount: widget.data.arrPaymentTypes.length,
                  shrinkWrap: true,
                ),
              ),
              Obx(() {
                // Check if the selected payment type is cashfree
                final isCashfreeSelected = widget.data.paymentType.value?.type == EPaymentType.cashOnDelivery;

                return isCashfreeSelected
                    ? AppButton(
                  title: 'Place Order',
                  onPressed: () => widget.data.purchase(),
                ): // Replace with the actual placeholder button
                    AppButton(
                  title: 'Pay Now',
                  onPressed: () => widget.data.purchase(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentTypeItemView extends StatefulWidget {
  final VMPaymentTypeItem data;
  final Rxn<VMPaymentTypeItem> selected;

  PaymentTypeItemView({super.key, required this.data, required this.selected});

  @override
  State<PaymentTypeItemView> createState() => _PaymentTypeItemViewState();
}

class _PaymentTypeItemViewState extends State<PaymentTypeItemView> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = (widget.data.type == widget.selected.value?.type);
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? appthemecolor1 : Colors.transparent,
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          color: isSelected ? Colors.red.shade100 : null,
        ),
        child: RadioListTile<EPaymentType>(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data.type.displayName,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                children: widget.data.type.cardImages
                    .map(
                      (e) => Image.asset(
                    'lib/images/paymentImg/$e.png',
                    height: 50,
                    width: 30,
                  ),
                )
                    .toList(),
              )
            ],
          ),
          value: widget.data.type,
          groupValue: widget.selected.value?.type,
          onChanged: (value) async {
            widget.selected.value = widget.data;

          },
          tileColor: Colors.transparent,
          selectedTileColor: Colors.transparent,
          activeColor: appthemecolor1,
        ),
      );
    });
  }
}


