import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sparebess/shared/theme.dart';

class OverlayItem {
  OverlayEntry? overlayEntry;
  final Widget Function(BuildContext context) widget;

  OverlayItem({
    required this.widget,
  });

  show() async {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(builder: widget);
      (await OverlayManager.shared.state).insert(overlayEntry!);
    }
  }

  hide() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}

class OverlayManager {
  static final shared = OverlayManager();
  final noAction = OverlayItem(
      widget: (_) => Container(
            color: Colors.white.withOpacity(0.0001),
          ));
  final loader = OverlayItem(
    widget: (_) => Container(
      color: Colors.black.withOpacity(0.25),
      child: Center(
        child: CircularProgressIndicator(
          color: appthemecolor1,
          backgroundColor: Colors.white,
        ),
      ),
    ),
  );

  Future<OverlayState> get state async {
    await Future.delayed(Duration.zero);
    return Overlay.of(Get.overlayContext!);
  }
}
