import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:logger/logger.dart';

import '../modules/onboard/screens/login_screen.dart';
import '/../controller/home_controller.dart';
import '/../manager/overlay.dart';
import '/../shared/theme.dart';

const url = 'https://api.sparewares.com';

const double hSpace = 15;

abstract class DateFormats {
  static const defaultFormat = 'dd/MM/yyyy, hh:mm a';
}

final logger = Logger(
  printer: PrettyPrinter(
    printTime: false,
    methodCount: 0,
    noBoxingByDefault: false,
    printEmojis: false,
  ),
);
const appName = 'SpareWares';
const websiteName = 'sparewares.com';

String priced(double value) {
  return '₹ ${value.toStringAsFixed(2)}';
}

double safeBottomIfNeed({double value = 10}) {
  final bottom = Get.mediaQuery.padding.bottom;
  return (bottom > 0) ? 0 : value;
}

double defaultBottomPadding({double value = 10}) {
  final bottom = Get.mediaQuery.padding.bottom;
  return (bottom > 0) ? bottom : value;
}

EdgeInsets get safeArea {
  return Get.mediaQuery.padding;
}

extension GetExt on GetInterface {
  popTo(String name) {
    Navigator.of(Get.context!)
        .popUntil((route) => route.settings.name == '/$name');
  }

  popToRoot() {
    Navigator.of(Get.context!).popUntil((route) => route.settings.name == '/');
    if (HomeController.to.tabIndex != 0) {
      HomeController.to.tabIndex = 0;
    }
  }
}

waitSomeTime() async {
  await Future.delayed(Duration.zero);
}

class LoadingState {
  late final Rx<RxStatus> state;
  final rxStatusDebounce = Debouncer(delay: Duration.zero);
  LoadingState({RxStatus? initialState}) {
    state = (initialState ?? RxStatus.loading()).obs;
  }

  bool get isLoading => state.value.isLoading;
  bool get isSuccess => state.value.isSuccess;
  bool get isError => state.value.isError;
  bool get isLoadingMore => state.value.isLoadingMore;
  bool get isEmpty => state.value.isEmpty;

  forceChange(RxStatus newStatus) {
    state.value = newStatus;
  }

  updateSuccess(bool isNotEmpty) {
    value = isNotEmpty ? RxStatus.success() : RxStatus.empty();
  }

  RxStatus get value {
    return state.value;
  }

  set value(RxStatus newStatus) {
    rxStatusDebounce.call(() {
      state.value = newStatus;

    });
  }
}

tryWithLoading(LoadingState state, Function() onTry,
    {bool interaction = false, bool showToastWhenError = false}) async {
  if (!interaction) {
    stopInteraction();
  }
  try {
    state.value = RxStatus.loading();
    await onTry();
  } catch (e) {
    state.value = RxStatus.error(e.extractErrorMsg);
    if (showToastWhenError) {
      showToast(e);
    }
  } finally {
    if (!interaction) {
      allowInteraction();
    }
  }
}

extension ObjectExt on Object {
  String get extractErrorMsg {
    if (this is DioException) {
      final dioException = this as DioException;
      if (dioException.message?.isNotEmpty ?? false) {
        return dioException.message!;
      } else {
        return dioException.error.toString();
      }
    } else {
      return toString();
    }
  }
}

showToast(Object error) {
  final displayMessage = error.extractErrorMsg;

  if (displayMessage != '') {
    print(displayMessage);
    Get.showSnackbar(
      GetSnackBar(
        message: displayMessage,
        duration: const Duration(seconds: 2),
      ),
    );
    if(displayMessage=="Not login please login"){
      Get.offAll(() => LoginScreen());
    }
  }
}

stopInteraction() {
  OverlayManager.shared.noAction.show();
}

allowInteraction() {
  OverlayManager.shared.noAction.hide();
}

showGlobalLoader() {
  OverlayManager.shared.loader.show();
}

hideGlobalLoader() {
  OverlayManager.shared.loader.hide();
}

extension StringExt on String {
  String get png {
    return 'assets/images/$this.png';
  }

  String get imageUrl {
    return '$url/$this';
  }
}

extension MapExt on Map {
  prettyPrint() {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(this);

  }
}

extension ListExt on List {
  reverse(bool shouldReverse) {
    return shouldReverse ? reversed.toList() : this;
  }
}

hideKeyboard(PointerDownEvent event) {
  dismissKeyboard();
}

dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class OptionalExpanded extends StatelessWidget {
  const OptionalExpanded(
      {super.key, required this.isExpanded, required this.child});
  final bool isExpanded;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return Expanded(child: child);
    } else {
      return child;
    }
  }
}

extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(transform ?? (e) => e).where((e) => e != null).cast();
}

class DefaultLoader extends StatelessWidget {
  const DefaultLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: appthemecolor1,
      ),
    );
  }
}
