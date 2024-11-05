import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/order_request.dart';
import 'package:sparebess/models/data_model/m_order_detail.dart';
import 'package:sparebess/models/data_model/m_order_list.dart';
import 'package:sparebess/modules/order/order_list/vm_order_list.dart';
import 'package:sparebess/modules/product/product_detail/product_detail_screen.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/shared/theme.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';
import 'package:sparebess/views/app_button.dart';
import 'package:sparebess/views/popup/cancel_order_dialog.dart';
import 'package:sparebess/views/rx_status_view/rx_status_view1.dart';
import 'package:sparebess/views/web_image_view.dart';

import '../../../views/shimmer/vertical_shimmer.dart';

class OrderListScreen extends StatelessWidget {
  OrderListScreen({super.key, required EOrderListType orderType}) {
    data = Get.put(VMOrderList(orderType: orderType));
    data.scOrderList();
  }

  late final VMOrderList data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: data.orderType.title),
      body: SafeArea(
        child: RxStatusView1(
          state: data.loadingState,
          child: () => Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(hSpace),
                  itemBuilder: (item, index) {
                    return OrderListItemView(data: data.arrOrder[index]);
                  },
                  separatorBuilder: (item, index) {
                    return const Gap(15);
                  },
                  itemCount: data.arrOrder.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListItemView extends StatelessWidget {
  const OrderListItemView({super.key, required this.data});

  final MOrderItem data;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFfCBCBCB), width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ]),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFFE7E7E7),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    OrderListSectionItemView1(
                      title: 'Order Placed',
                      desc: DateFormat(DateFormats.defaultFormat)
                          .format(data.date),
                    ),
                    const Spacer(),
                    OrderListSectionItemView1(
                      title: 'Order ID',
                      desc: data.orderNumber,
                      alignment: CrossAxisAlignment.end,
                    ),
                  ],
                ),
                Divider(
                  color: appthemecolor1.withOpacity(0.2),
                  thickness: 0.5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OrderListSectionItemView1(
                        title: 'Total',
                        desc: priced(data.orderTotalAmount),
                        descTextColor: Colors.green,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          OrderListSectionItemView1(
                            title: 'Status',
                            desc: (data.status.name.capitalizeFirst ?? '') +
                                ((data.status == EOrderStatus.cancelled)
                                    ? '\n${DateFormat(DateFormats.defaultFormat).format(data.date)}'
                                    : ''),
                            alignment: CrossAxisAlignment.end,
                          ),
                          if (data.status == EOrderStatus.pending)
                            GestureDetector(
                              onTap: () {
                                Get.dialog(
                                  CancelOrderDialog(
                                    onCancel: () async {
                                      try {
                                        showGlobalLoader();
                                        final res =
                                            await OrderRequest.cancelOrder(
                                                    data.id)
                                                .load();
                                      } finally {
                                        Get.find<VMOrderList>().scOrderList();
                                        hideGlobalLoader();
                                      }
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: appthemecolor1),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() {
            final items = data.detail.value?.data ?? [];
            if (data.detail.value == null) {
              return SizedBox(
                height:
                    ((80 * data.totalProducts) + (15 * data.totalProducts) + 15)
                        .toDouble(),
                child: VerticalListShimmer(
                  padding: const EdgeInsets.all(15),
                  size: 80,
                  gap: 15,
                  length: data.totalProducts,
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(items.isNotEmpty ? 10 : 0),
                itemBuilder: (context, index) {
                  return OrderListProductItemView(
                    data: items[index],
                    order: data,
                  );
                },
                separatorBuilder: (item, index) {
                  return SizedBox(
                    height: 20,
                    child: Divider(
                      thickness: 0.5,
                      height: 0,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  );
                },
                itemCount: items.length,
              );
            }
          }),
        ],
      ),
    );
  }
}

class OrderListSectionItemView1 extends StatelessWidget {
  const OrderListSectionItemView1(
      {super.key,
      this.alignment = CrossAxisAlignment.start,
      required this.title,
      required this.desc,
      this.descTextColor});

  final String title;
  final String desc;
  final CrossAxisAlignment alignment;
  final Color? descTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF7E7E7E),
          ),
        ),
        Text(
          desc,
          textAlign: alignment == CrossAxisAlignment.start
              ? TextAlign.left
              : TextAlign.right,
          style: TextStyle(
            fontSize: 14,
            color: descTextColor ?? Colors.grey.shade800,
          ),
        ),
      ],
    );
  }
}

class OrderListProductItemView extends StatelessWidget {
  const OrderListProductItemView(
      {super.key, required this.data, required this.order});
  final MOrderItem order;
  final MOrderDetail data;


  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 60,
          width: 70,
          child: WebImageView(
            data.productId?.images.firstOrNull?.imageUrl,
            //data.productId?.images.firstOrNull?.imageUrl,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.orderProductName,
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(5),
              Text(
                order.status.detailText,
                style: TextStyle(
                  fontSize: 14,
                  color: appthemecolor1,
                ),
              ),
              const Gap(5),
              Row(
                children: [
                  AppButton(
                    title: 'Buy Again',
                    fontSize: 14,
                    height: 30,
                    onPressed: () {

                      if (data.productId?.id != null) {
                        Get.to(() => ProductDetailScreen(id: data.productId!.id),
                        );
                      } else {
                        showToast('Product not available');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
