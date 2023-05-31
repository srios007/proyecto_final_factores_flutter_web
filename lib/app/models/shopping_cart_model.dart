import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';

class ShoppingCartModel {
  Product? product;
  RxInt? stock = 1.obs;

  ShoppingCartModel({
    this.stock,
    this.product,
  });
}
