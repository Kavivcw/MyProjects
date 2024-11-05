import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared/theme.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
    this.onTapIndex,
  });
  final int total;
  final Rx<int> currentIndex;
  final Function(int)? onTapIndex;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final currentValue = currentIndex.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            total,
            (index) => GestureDetector(
              onTap: () {
                if (onTapIndex != null) {
                  onTapIndex!(index);
                }
              },
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      currentIndex.value == index ? appthemecolor1 : Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
