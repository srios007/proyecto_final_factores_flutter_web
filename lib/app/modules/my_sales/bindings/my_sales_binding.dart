import 'package:get/get.dart';

import '../controllers/my_sales_controller.dart';

class MySalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MySalesController>(
      () => MySalesController(),
    );
  }
}
