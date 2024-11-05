import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sparebess/modules/onboard/screens/login_screen.dart';
import 'package:sparebess/shared/constant.dart';

import '../../../shared/theme.dart';
import '../model/vm_welcome.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: PageView(
          controller: controller,
          children: VMWelcomeContent.list.indexed
              .map(
                (item) => WelcomePageItemView(
                  data: item.$2,
                  onBack: item.$1 != 0 ? onBack : null,
                  previous: item.$1 == (VMWelcomeContent.list.length - 1)
                      ? null
                      : onDone,
                  forward: item.$1 == (VMWelcomeContent.list.length - 1)
                      ? null
                      : onNext,
                  done: item.$1 == (VMWelcomeContent.list.length - 1)
                      ? onDone
                      : null,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  onBack() {
    controller.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  onNext() {
    controller.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

  onDone() {
    Get.to(() => LoginScreen());
  }
}

class WelcomePageItemView extends StatelessWidget {
  const WelcomePageItemView({
    super.key,
    this.onBack,
    required this.data,
    this.forward,
    this.previous,
    this.done,
  });
  final VMWelcomeContent data;
  final VoidCallback? onBack;
  final VoidCallback? forward;
  final VoidCallback? previous;
  final VoidCallback? done;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(child: WelcomeContentView(data: data)),
            WelcomeBottomButtonView(
              forward: forward,
              previous: previous,
              done: done,
            ),
          ],
        ),
        if (onBack != null)
          Positioned(
            child: Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_sharp),
                  color: Colors.white,
                  onPressed: onBack,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class WelcomeContentView extends StatelessWidget {
  const WelcomeContentView({super.key, required this.data});
  final VMWelcomeContent data;
  @override
  Widget build(BuildContext context) {
    final width = context.mediaQuery.size.width;
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color:  appthemecolor1,
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(width / 2),
                bottomStart: Radius.circular(width / 2),
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                data.image.png,
                width: width * 0.7,
                // scale: 2.0,
              ),
            ),
          ),
        ),
        const Gap(20),
        Text(
          data.title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            data.description,
            textAlign: TextAlign.center,
            style:
                const TextStyle(color: Colors.grey, fontFamily: "Amazon Ember"),
          ),
        )
      ],
    );
  }
}

class WelcomeBottomButtonView extends StatelessWidget {
  const WelcomeBottomButtonView(
      {super.key,
      required this.forward,
      required this.previous,
      required this.done});
  final VoidCallback? forward;
  final VoidCallback? previous;
  final VoidCallback? done;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (previous != null)
          TextButton(
            onPressed: previous,
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.grey, fontFamily: "Amazon Ember"),
            ),
          ),
        const Spacer(),
        if (forward != null)
          TextButton(
            onPressed: forward,
            child: Text(
              "Go",
              style:
                  TextStyle(color: appthemecolor1, fontFamily: "Amazon Ember"),
            ),
          ),
        if (done != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: done,
              // onPressed: () => Get.to(const LoginView()),
              style: ElevatedButton.styleFrom(
                backgroundColor: appthemecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                shadowColor: Colors.grey,
                elevation: 8,
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (done != null) Spacer(),
      ],
    );
  }
}
