import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/constant.dart';

import '../controller/wish_list_controller.dart';
import '../shared/theme.dart';

class WishListButton extends StatelessWidget {
  WishListButton({
    super.key,
    required this.productId,
    required this.state,
    this.color,
  });
  final LoadingState state;
  final String productId;
  final Color? color;
  final controller = WishListController.to;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return IconButton(
        onPressed: () {
          tryWithLoading(state, () async {
            final res = await WishListController.to.scToggle(productId);
            state.value = RxStatus.success();
          });
        },
        icon: state.value.isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: color ?? appthemecolor1),
              )
            : Icon(
                controller.getStatus(productId)
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: color ?? appthemecolor,
                size: 20,
              ),
        color: color ?? appthemecolor1,
      );
    });
  }
}
