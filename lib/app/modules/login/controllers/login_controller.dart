import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  double opacity = 0;
  RxDouble scrollPosition = 0.0.obs;
  ScrollController scrollController = ScrollController();
  final count = 0.obs;
  @override
  void onInit() {
    // scrollController.addListener(scrollListener);
    super.onInit();
  }

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
    // scrollPosition.value = scrollController.position.pixels;
  }
}