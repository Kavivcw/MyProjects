class MLogin {
  late final String message;
  late final String token;
  late final MLoginData data;

  MLogin(Map<String, dynamic> json) {
    message = json['Message'];
    token = json['token'];
    data = MLoginData(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Message'] = message;
    data['token'] = token;
    data['data'] = this.data.toJson();
    return data;
  }
}

class MLoginData {
  late final MUser user;

  MLoginData(Map<String, dynamic> json) {
    user = MUser(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    return data;
  }
}

class MUser {
  late final String userId;
  late final String userName;
  late final String userEmail;
  late final String customerId;
  late final String userNumber;
  final userType = 'Customer';

  MUser(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'] ?? '';
    customerId = json['customerId'];
    userNumber = json['user_number'];
  }

  get name => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_email'] = userEmail;
    data['customerId'] = customerId;
    data['user_number'] = userNumber;
    return data;
  }
}
