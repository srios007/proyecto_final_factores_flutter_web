import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/purchase_model.dart';

import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class PurchasesService {
  factory PurchasesService() {
    return _instance;
  }
  PurchasesService._internal();
  static String purchaseReference = firebaseReferences.purchases;
  static final PurchasesService _instance = PurchasesService._internal();
  var firestore = FirebaseFirestore.instance;

  // getAllProducts() async {
  //   RxList products = [].obs;
  //   final querySnapshot = await database.getData(productsReference);
  //   if (querySnapshot.docs.isEmpty) return [];

  //   for (final product in querySnapshot.docs) {
  //     products.add(Product.fromJson(
  //       product.data() as Map<String, dynamic>,
  //     ));
  //   }
  //   return products;
  // }

  Future<RxList> getPurchasesByUserId(String clientId) async {
    RxList purchases = [].obs;
    final querySnapshot = await database.getDataByCustonParam(
      clientId,
      purchaseReference,
      'shopId',
    );

    if (querySnapshot.docs.isEmpty) return [].obs;
    // print('si hay');
    for (final purchase in querySnapshot.docs) {
      purchases.add(Purchase.fromJson(
        purchase.data() as Map<String, dynamic>,
        isGet: true,
      ));
    }
    return purchases;
  }

  Future<bool> addPurchase({
    required Purchase purchase,
  }) async {
    try {
      await database.saveDocumentInCollection(
        collection: purchaseReference,
        collectionData: purchase.toJson(),
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  updatePurchase({
    required String purchaseId,
    required Purchase data,
  }) async {
    try {
      await database.updateDocument(
        purchaseId,
        data.toJson(),
        purchaseReference,
      );
    } on Exception catch (e) {
      CustomSnackBars.showErrorSnackBar(
        'Hubo un error al actualizar el producto',
      );
      print(e);
      return false;
    }
  }
}

PurchasesService purchasesService = PurchasesService();
