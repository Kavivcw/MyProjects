import 'package:sparebess/manager/network_manager/network_manager.dart';

import '../../../models/data_model/m_address.dart';
import '../request.dart';

abstract class AddressRequest {
  static Request<MAddressListResponse> addressList() {
    return Request(
      MAddressListResponse.new,
      endPoint: 'fetch_address',
      method: Method.get,
      path: Path.address,
    );
  }

  static Request<MDefault> makeDefault(String id) {
    return Request(
      MDefault.new,
      endPoint: 'activateaddress',
      method: Method.put,
      path: Path.user,
      param: {'arrayId': id},
    );
  }

  static Request<MDefault> addAddress(Map<String, dynamic> param) {
    return Request(
      MDefault.new,
      endPoint: 'post_address',
      method: Method.post,
      path: Path.address,
      param: param,
    );
  }

  static Request<MDefault> updateAddress(
      String id, Map<String, dynamic> param) {
    return Request(
      MDefault.new,
      endPoint: 'update_address/$id',
      method: Method.patch,
      path: Path.address,
      param: param,
    );
  }

  static Request<MDefault> delete(String id) {
    return Request(
      MDefault.new,
      endPoint: 'delete_address/$id',
      method: Method.delete,
      path: Path.address,
    );
  }
}
