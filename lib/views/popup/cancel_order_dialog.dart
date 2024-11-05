import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_button.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({super.key, required this.onCancel});
  final VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back(canPop: false);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(hSpace),
              padding: EdgeInsets.all(hSpace),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.orange,
                    size: 70,
                  ),
                  const Gap(hSpace),
                  const Text(
                    'Are you sure?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(hSpace),
                  const Text('You are about to cancel this order!'),
                  const Gap(hSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        title: 'Yes, cancel it!',
                        backgroundColor: Colors.blue,
                        borderRadius: 8,
                        fontSize: 14,
                        height: 35,
                        onPressed: () {
                          onCancel();
                          Get.back(canPop: false);
                        },
                      ),
                      const Gap(15),
                      AppButton(
                        title: 'Dismiss',
                        // backgroundColor: Colors.blue,
                        borderRadius: 8,
                        fontSize: 14,
                        height: 35,
                        onPressed: () {
                          Get.back(canPop: false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
