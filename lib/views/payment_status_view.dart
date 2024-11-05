import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_button.dart';

class PaymentStatusView extends StatelessWidget {
  const PaymentStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(hSpace),
            margin: const EdgeInsets.all(hSpace),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: appthemecolor1,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.done,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
                const Gap(15),
                Text(
                  'Thank you!',
                  style: TextStyle(
                    fontSize: 22,
                    color: appthemecolor1,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway-Regular',
                  ),
                ),
                const Gap(15),
                const Text(
                  'Purchase was successful',
                  style: TextStyle(
                    fontSize: 15,
                    // color: appthemecolor1,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway-Regular',
                  ),
                ),
                const Gap(15),
                AppButton(
                  title: 'Done',
                  onPressed: () {
                    Get.back(result: true, closeOverlays: true, canPop: false);
                  },
                  height: 50,
                  borderRadius: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
