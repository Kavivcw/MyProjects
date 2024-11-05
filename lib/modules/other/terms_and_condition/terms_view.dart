import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/manager/network_manager/requests/other_request.dart';
import 'package:sparebess/models/response_model/terms_condition/m_terms_conditions.dart';
import 'package:sparebess/views/app_bar/default_app_bar.dart';

class TermsView extends StatefulWidget {
  const TermsView({super.key});

  @override
  State<TermsView> createState() => _TermsViewState();
}

class _TermsViewState extends State<TermsView> {
  final data = Rxn<MTermsConditions>(null);

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    final res = await OtherRequest.termsConditions().load();
    data.value = res.data.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Terms and Conditions',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Html(data: data.value?.content ?? "");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
