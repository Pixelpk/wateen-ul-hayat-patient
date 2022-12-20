import 'package:get/get.dart';
import 'package:swift_care/pages/home/presentation/controllers/home_controller.dart';

import '../presentation/controllers/book_service_provider_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
