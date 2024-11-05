import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalListShimmer extends StatelessWidget {
  final double? dimension;
  final double gap;
  final int crossAxisCount;
  final EdgeInsetsGeometry padding;
  const HorizontalListShimmer({
    super.key,
    this.gap = kMinInteractiveDimension,
    this.crossAxisCount = 2,
    this.dimension,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    var defaultDimension = (context.width / crossAxisCount) - 24.0;

    var height = dimension ?? defaultDimension;

    return SizedBox(
      height: height,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        scrollDirection: Axis.horizontal,
        itemCount: crossAxisCount,
        separatorBuilder: (context, index) => SizedBox(width: gap),
        itemBuilder: (BuildContext context, int index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox.fromSize(
                size: Size.square(height),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DefaultShimmer extends StatelessWidget {
  const DefaultShimmer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Material(
        child: child,
      ),
    );
  }
}
