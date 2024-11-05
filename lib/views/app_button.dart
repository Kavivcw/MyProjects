import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/constant.dart';

import '../shared/theme.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.height,
    this.onPressed,
    LoadingState? state,
    this.backgroundColor,
    this.borderRadius,
  }) {
    status = state ?? LoadingState(initialState: RxStatus.success());
  }

  final String title;
  final double fontSize;
  final double? height;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  late final LoadingState status;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? appthemecolor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
            ),
            shadowColor: Colors.black.withOpacity(0.8),
            elevation: 8,
          ),
          child: Container(
              // margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              height: fontSize + 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: status.value.isLoading ? 0 : 1,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (status.value.isLoading)
                    SizedBox(
                      height: fontSize + 10,
                      width: fontSize + 10,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              )),
        ),
      );
    });
    // if (status.value.isLoading) {
    //   return Container(
    //     decoration: BoxDecoration(
    //       border: Border.all(color: appthemecolor1),
    //       borderRadius: BorderRadius.circular(10.0),
    //     ),
    //     child: Center(
    //       child: ,
    //     ),
    //   );
    // } else {
    //
    // }
  }
}
