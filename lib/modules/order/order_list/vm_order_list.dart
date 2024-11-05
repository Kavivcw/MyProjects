import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/models/data_model/m_order_detail.dart';
import 'package:sparebess/models/data_model/m_order_list.dart';
import 'package:sparebess/shared/constant.dart';

enum EOrderListType {
  recent,
  history;

  String get title {
    switch (this) {
      case EOrderListType.recent:
        return 'My Orders';
      case EOrderListType.history:
        return 'Order History';
    }
  }

  List<String> get allowedStatus {
    switch (this) {
      case EOrderListType.recent:
        return [];
      case EOrderListType.history:
        return [];
    }
  }
}

final class VMOrderList extends GetxController {
  final EOrderListType orderType;
  final arrOrder = <MOrderItem>[].obs;
  final loadingState = LoadingState();
  VMOrderList({required this.orderType});
  scOrderList() async {
    try {
      final response = await OrderRequest.orderList().load(state: loadingState);
      arrOrder.value = response.data;
      loadingState.updateSuccess(arrOrder.isNotEmpty);
      for (final item in arrOrder) {
        item.detail.value = await scOrderDetail(item.id);
      }
    } finally {}
  }

  Future<MOrderDetailResponse?> scOrderDetail(String id) async {
    try {
      final response = await OrderRequest.orderItemDetail(id).load();
      return response;
    } catch (e) {
      return null;
    }
  }
}
