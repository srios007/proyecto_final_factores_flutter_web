import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class RegisterProductController extends GetxController {
  ScrollController scrollController = ScrollController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final key = GlobalKey<FormState>();
  RxBool isLoadingPP = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingBut = false.obs;
  Product product = Product();
  Uint8List? bytesFromPicker;
  late var signUpResult;
  String selctFile = '';
  var rng = Random();
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = (await userService.getCurrentUser())!;
    print(user.id);
    isLoading.value = false;
  }

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
  }

  /// Asignar usuario al modelo
  assignProduct(String pPicture) {
    product.name = nameController.text;
    product.description = descController.text;
    product.price = int.parse(priceController.text);
    product.imageUrl = pPicture;
    product.shopId = user.id;
  }

  /// Valida si tiene o no foto para subirla
  uploadFoto() async {
    if (bytesFromPicker != null) {
      final urlRutResult = await storageService.uploadFile(
        '${user.id!}/product_files',
        rng.nextInt(100000000).toString(),
        bytesFromPicker!,
      );
      print(urlRutResult);

      assignProduct(urlRutResult!);
    } else {
      assignProduct('');
    }
  }

  /// Guarda el usuario en firebase
  saveUserInFirebase() async {
    final result = await productsService.save(product: product);
    if (result) {
      Get.offAllNamed(Routes.HOME);
    } else {
      CustomSnackBars.showErrorSnackBar(
        'Error al crear el producto, por favor intenta de nuevo',
      );
    }
  }

  /// Registra al usuario
  register() async {
    if (bytesFromPicker == null) {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, sube una foto para tu producto',
      );
    } else if (key.currentState!.validate()) {
      try {
        isLoadingBut.value = true;
        await uploadFoto();
        await saveUserInFirebase();

        isLoadingBut.value = false;
      } catch (e) {
        print(e.toString());

        CustomSnackBars.showErrorSnackBar(
          'Error al crear el producto, por favor intenta de nuevo',
        );
        isLoadingBut.value = false;
      }
    }
  }

  showPicker() async {
    isLoadingPP.value = true;
    bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    isLoadingPP.value = false;
  }
}
