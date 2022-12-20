import 'package:swift_care/main.dart';

import '../../../export.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  /// Mocks a login process
  final isLoggedIn =
      storage.read(LOCALKEY_token) != null ? true.obs : false.obs;
  bool get isLoggedInValue => isLoggedIn.value;

  void login() {
    isLoggedIn.value = true;
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
