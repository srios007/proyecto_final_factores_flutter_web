import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/purchase_model.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';

class MySalesController extends GetxController {
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
    products.value = await purchasesService.getPurchasesByUserId(user.id!);
    isLoading.value = false;
  }

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
    // scrollPosition.value = scrollController.position.pixels;
  }

  changeState(Purchase purchase, String state) async {
    purchase.state = state;
    await purchasesService.updatePurchase(
      purchaseId: purchase.id!,
      data: purchase,
    );
    await getData();
  }
}
