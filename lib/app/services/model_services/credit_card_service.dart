import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';

class CreditCardService {
  factory CreditCardService() {
    return _instance;
  }
  CreditCardService._internal();
  static String usersReference = firebaseReferences.users;
  static String creditCardsReference = firebaseReferences.creditCards;
  static final CreditCardService _instance = CreditCardService._internal();

  // Credit cards
  Future<bool> addCreditCard({
    required String documentId,
    required CreditCard creditCard,
  }) async {
    try {
      await database.saveDocumentInSubcollection(
        collection: firebaseReferences.users,
        subcollection: firebaseReferences.creditCards,
        documentId: documentId,
        subcollectionData: creditCard.toJson(),
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCreditCard({
    required String collectionDocumentId,
    required String subcollectionDocumentId,
  }) async {
    try {
      await database.deleteDocumentFromSubcollection(
        collectionDocumentId,
        firebaseReferences.users,
        subcollectionDocumentId,
        firebaseReferences.creditCards,
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<RxList> getUserCreditCards({
    required String documentId,
  }) async {
    final RxList list = [].obs;
    try {
      final subcollection = await database.getSubcollectionFromDocument(
          documentId, firebaseReferences.users, firebaseReferences.creditCards);

      for (final creditCardDoc in subcollection.docs) {
        final newCreditCard = CreditCard.fromJson(creditCardDoc.data());
        newCreditCard.id = creditCardDoc.id;
        list.add(newCreditCard);
      }
      return list;
    } on Exception catch (e) {
      print(e);
      return list;
    }
  }
}

CreditCardService creditCardService = CreditCardService();
