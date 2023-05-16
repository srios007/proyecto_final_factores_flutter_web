import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/product_model.dart';

import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';

class ProductsService {
  factory ProductsService() {
    return _instance;
  }
  ProductsService._internal();
  static String productsReference = firebaseReferences.products;
  static final ProductsService _instance = ProductsService._internal();
  var firestore = FirebaseFirestore.instance;

  getAllProducts() async {
    RxList products = [].obs;
    final querySnapshot = await database.getData(productsReference);
    if (querySnapshot.docs.isEmpty) return [];

    for (final product in querySnapshot.docs) {
      products.add(Product.fromJson(
        product.data() as Map<String, dynamic>,
      ));
    }
    return products;
  }
}

ProductsService productsService = ProductsService();
