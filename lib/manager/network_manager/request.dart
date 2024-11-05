import 'package:dio/dio.dart';
import 'package:sparebess/models/params/paramable.dart';
import 'package:sparebess/shared/constant.dart';

typedef ModelFunction<T> = T Function(Map<String, dynamic>);

abstract class Path {
  static const user = 'user';
  static const cart = 'cart';
  static const order = 'order';
  static const address = 'address';
}

abstract class Method {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}

class Request<T> extends RequestOptions {
  final ModelFunction<T> model;
  Request(
    this.model, {
    String? baseURL,
    required String endPoint,
    required String path,
    required String method,
    dynamic param,
  }) {
    final finalBaseURL = baseURL ?? url;
    baseUrl = '$finalBaseURL/$path/';
    this.path = endPoint;
    this.method = method;
    dynamic finalParam;

    if (param is Map<String, dynamic>) {
      finalParam = param;
    } else if (param is Encodable) {
      finalParam = param.toJson();
    }

    switch (method) {
      case 'GET':
        if (finalParam is Map<String, dynamic>) {
          queryParameters = finalParam;
        }
      default:
        data = finalParam;
    }
  }

  // static Request<T> post<T>(ModelFunction<T> model,
  //     {required String endPoint,
  //     required String path,
  //     required,
  //     dynamic param}) {
  //   final req = Request(model);
  //   req.baseUrl = '${Request.baseURL}$path/';
  //   req.path = endPoint;
  //   req.method = 'POST';
  //   if (param is Map<String, dynamic>) {
  //     req.data = param;
  //   } else if (param is Encodable) {
  //     req.data = param.toJson();
  //   }
  //   return req;
  // }
}

extension RequestOptionsExt on RequestOptions {
  skipAuth() {
    extra['noAuth'] = true;
  }
}
