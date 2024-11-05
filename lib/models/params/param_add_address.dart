import 'package:sparebess/models/params/paramable.dart';

class ParamAddAddress implements Encodable {
  final String s_country;
  final String s_fname;
  final String s_number;
  final String s_address;
  final String s_city;
  final String s_state;
  final String s_pincode;
  final bool defaultAddress;
  ParamAddAddress({
    required this.s_country,
    required this.s_fname,
    required this.s_number,
    required this.s_address,
    required this.s_city,
    required this.s_state,
    required this.s_pincode,
    required this.defaultAddress,
  });

  @override
  Map<String, dynamic> toJson() => {
        's_country': s_country,
        's_fname': s_fname,
        's_number': s_number,
        's_address': s_address,
        's_city': s_city,
        's_state': s_state,
        's_pincode': s_pincode,
        'defaultAddress': defaultAddress,
      };
}
