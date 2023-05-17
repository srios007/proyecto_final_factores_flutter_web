import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';

class HomeController extends GetxController {
  ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;
  RxBool isLoading = false.obs;
  RxList products = [].obs;
  double opacity = 0;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = (await userService.getCurrentUser())!;
    products.value = await productsService.getAllProductsByShop(user.id!);
    isLoading.value = false;
  }

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
    // scrollPosition.value = scrollController.position.pixels;
  }
}
