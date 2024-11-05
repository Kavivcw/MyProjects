import 'package:sparebess/manager/network_manager/network_manager.dart';
import 'package:sparebess/models/response_model/terms_condition/m_cancellation_policy.dart';
import 'package:sparebess/models/response_model/terms_condition/m_privacy.dart';
import 'package:sparebess/models/response_model/terms_condition/m_terms_conditions.dart';

import '../request.dart';



abstract class OtherRequest {
  static Request<MPrivacyResponse> privacyPolicy() {
    return Request(
      MPrivacyResponse.new,
      endPoint: 'get',
      method: Method.get,
      path: 'privacy_policy',
    );
  }

  static Request<MTermsConditionResponse> termsConditions() {
    return Request(
      MTermsConditionResponse.new,
      endPoint: 'get',
      method: Method.get,
      path: 'terms_condition',
    );
  }

  static Request<MCancellationPolicyResponse> cancellation() {
    return Request(
      MCancellationPolicyResponse.new,
      endPoint: 'get',
      method: Method.get,
      path: 'refund_cancellation',
    );
  }

  static Request<MDefault> sendSMS(
      {required String mobileNumber, required String otp}) {
    final params = {
      'user': 'sparewares',
      'authkey': '92Xa0RFQ93Rrk',
      'sender': 'SPWRES',
      'mobile': mobileNumber,
      'text': '[SpareWares.com] your OTP for login/registration is $otp Please enter this code to access your account. This OTP is valid for 10 minutes. Crafty components',
      'entityid': '1001635210966519359',
      'templateid': '1007213056811541789',
    };

    return Request(
      MDefault.new,
      baseURL: 'https://amazesms.in',
      endPoint: 'pushsms',
      path: 'api',
      param: params,
      method: Method.get,
    );
  }
}
