import 'package:flutter/material.dart';
import 'package:sparebess/shared/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffAE0000),
      body: Center(
        child: LayoutBuilder(
          builder: (con, constraint) {
            return Image.asset(
              'logo_white'.png,
              width: constraint.maxWidth * 0.75,
            );
          },
        ),
      ),
    );
  }
}
