import 'package:get/get.dart';
import 'package:swift_care/pages/staticPages/presentation/controllers/static_page_controller.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StaticPageController>(
      () => StaticPageController(),
    );
  }
}
