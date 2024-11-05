import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/other_request.dart';
import 'package:sparebess/models/response_model/terms_condition/m_privacy.dart';
import 'package:sparebess/shared/constant.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

class PrivacyPolicyView extends StatefulWidget {
  const PrivacyPolicyView({super.key});

  @override
  State<PrivacyPolicyView> createState() => _PrivacyPolicyViewState();
}

class _PrivacyPolicyViewState extends State<PrivacyPolicyView> {
  final data = Rxn<MPrivacy>(null);

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final res = await OtherRequest.privacyPolicy().load();
    data.value = res.data.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Privacy Policy',
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(hSpace),
            child: Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                    data: data.value?.content ?? "",
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
