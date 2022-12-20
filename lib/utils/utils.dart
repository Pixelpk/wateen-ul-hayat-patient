import 'package:swift_care/main.dart';

import '../service/local_service/local_keys.dart';

bool isDarkMode() {
  bool isDarkModeEnable = storage.read(LOCALKEY_darkTheme) ?? false;
  return isDarkModeEnable;
}
