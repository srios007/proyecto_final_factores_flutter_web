import 'package:get/get.dart';

import '../controllers/register_product_controller.dart';

class RegisterProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterProductController>(
      () => RegisterProductController(),
    );
  }
}
