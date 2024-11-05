import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:sparebess/controller/auth_controller.dart';

import '../../shared/constant.dart';
import 'request.dart';

class MDefault {
  late final String message;
  late final bool success;
  MDefault(Map<String, dynamic> json) {
    message = json['message'] ?? json['Message'] ?? '';
    success = json['success'] ?? json['Success'] ?? false;
  }
}

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['noAuth'] == null) {
      options.headers.addAll(
          {'Authorization': 'Bearer ${AuthController.to.accessToken.val}'});
    }
    super.onRequest(options, handler);
  }
}

class Network {
  static final shared = Network();
  final dio = Dio(BaseOptions());

  Network() {
    // dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(NetworkInterceptor());
  }

  Future<T> load<T>(
    Request<T> request, {
    LoadingState? state,
    bool interaction = true,
    bool showErrorToast = false,
    bool showLoading = true,
  }) async {
    if (!interaction) {
      stopInteraction();
    }
    try {
      if (showLoading) {
        state?.value = RxStatus.loading();
      }
      final response = await dio.fetch(request);
      final model = request.model(response.data);
      state?.value = RxStatus.success();
      return model;
    } catch (e, stackTrace) {
      logger.e(e);
      logger.i(stackTrace);
      final error = modifiedError(e);
      state?.value = RxStatus.error(error.extractErrorMsg);
      if (showErrorToast) {
        showToast(error);
      }
      throw error;
    } finally {
      if (!interaction) {
        allowInteraction();
      }
    }
  }

  Object modifiedError(Object err) {
    String? errorMsg;
    if (err is DioException) {
      if (err.response?.data is Map<String, dynamic>) {
        errorMsg = MDefault(err.response?.data).message;
      } else if (err.response?.data is String) {
        errorMsg = err.response?.data;
      }
      if (errorMsg != null) {
        return DioException(
          requestOptions: err.requestOptions,
          message: errorMsg,
          type: DioExceptionType.badResponse,
        );
      }
    }
    return err;
  }

  // T decode<T>(T Function(Map<String, dynamic>) constructorFunction) {
  //   return constructorFunction(json);
  // }
}

extension RequestExt<T> on Request<T> {
  Future<T> load({
    LoadingState? state,
    bool interaction = true,
    bool showErrorToast = false,
    bool showLoading = true,
  }) async {
    return await Network.shared.load(this,
        state: state,
        interaction: interaction,
        showErrorToast: showErrorToast,
        showLoading: showLoading);
  }
}
