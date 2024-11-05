import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sparebess/shared/extensions.dart';

class VerticalListShimmer extends StatelessWidget {
  final int? length;
  final double gap;
  final double size;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  const VerticalListShimmer({
    super.key,
    this.gap = kRadialReactionRadius,
    this.size = kMinInteractiveDimension,
    this.length,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: LayoutBuilder(builder: (context, constraints) {
        bool hasNoHeight = !constraints.maxHeight.isValid || !size.isValid;
        var length = hasNoHeight ? this.length : constraints.maxHeight ~/ size;
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: padding,
          itemCount: this.length ?? length ?? 1,
          separatorBuilder: (context, index) => SizedBox(height: gap),
          itemBuilder: (BuildContext context, int index) {
            return Material(
              borderRadius: BorderRadius.circular(borderRadius),
              child: SizedBox.fromSize(
                size: Size.fromHeight(size),
              ),
            );
          },
        );
      }),
    );
  }
}
