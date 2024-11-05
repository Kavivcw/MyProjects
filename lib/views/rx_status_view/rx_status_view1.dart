import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/constant.dart';

import '../shimmer/vertical_shimmer.dart';

class RxStatusView1 extends StatelessWidget {
  const RxStatusView1({
    super.key,
    required this.state,
    this.shimmerHeight = 100,
    required this.child,
    this.loader,
  });
  final LoadingState state;
  final Widget? loader;
  final double shimmerHeight;
  final Widget Function() child;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (state.value.isLoading) {
        // return Center(child: CircularProgressIndicator(color: appthemecolor1));
        return loader ??
            VerticalListShimmer(
              padding: const EdgeInsets.all(15),
              size: shimmerHeight,
              gap: 15,
            );
      } else if (state.value.isEmpty || state.value.isError) {
        return Center(
          child: Text(
            state.value.errorMessage ?? 'No data available',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else {
        return child();
      }
    });
  }
}

class RxStatusView2 extends StatelessWidget {
  const RxStatusView2({
    super.key,
    required this.state,
    required this.loader,
    this.emptyView,
    required this.builder,
  });
  final LoadingState state;
  final Widget loader;
  final Widget? emptyView;
  final Widget Function() builder;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (state.value.isLoading) {
        return loader;
      } else if (state.value.isSuccess) {
        return builder();
      } else {
        return emptyView ?? const SizedBox.shrink();
      }
    });
  }
}
