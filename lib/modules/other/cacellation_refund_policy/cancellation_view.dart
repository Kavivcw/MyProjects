import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/other_request.dart';
import 'package:sparebess/models/response_model/terms_condition/m_cancellation_policy.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

class CancellationView extends StatefulWidget {
  const CancellationView({super.key, required this.title});
  final String title;

  @override
  State<CancellationView> createState() => _CancellationViewState();
}

class _CancellationViewState extends State<CancellationView> {
  final data = Rxn<MCancellationPolicy>(null);

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final res = await OtherRequest.cancellation().load();
    data.value = res.data.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: widget.title,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(hSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Html(data: data.value?.content ?? '');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
