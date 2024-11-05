import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_button.dart';

class EmptyTextAndButtonView extends StatelessWidget {
  const EmptyTextAndButtonView(
      {super.key,
      required this.text,
      required this.buttonTitle,
      required this.onPressed});
  final String text;
  final String buttonTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(hSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  title: buttonTitle,
                  fontSize: 14,
                  onPressed: onPressed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
