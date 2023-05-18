import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class RegisterController extends GetxController {
  ScrollController scrollController = ScrollController();
  final TextEditingController confPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final key = GlobalKey<FormState>();
  RxBool showConfPass = false.obs;
  RxBool isLoadingPP = false.obs;
  RxBool isLoading = false.obs;
  RxBool showPass = false.obs;
  Uint8List? bytesFromPicker;
  RxBool terms = false.obs;
  late var signUpResult;
  String selctFile = '';
  User user = User();

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
  }

  /// Muestra u oculta la contraseña
  showPassword() {
    showPass.value = !showPass.value;
  }

  /// Muestra u oculta el confirmar contraseña
  showConfPassword() {
    showConfPass.value = !showConfPass.value;
  }

  /// Cambia el estado del checkbox de términos y condiciones
  onChangedT() {
    terms.value = !terms.value;
  }

  /// Va a la pantalla de términos y condiciones
  goToTerms() {
    print('LLeva a términos y condiciones');
  }

  /// Va a la pantalla de políticas de privacidad
  goToPolicies() {
    print('LLeva a políticas de privacidad');
  }

  /// Asignar usuario al modelo
  assignUser(String pPicture) {
    user.name = nameController.text;
    user.lastname = '';
    user.enail = emailController.text;
    user.enail = emailController.text;
    user.profilePictureUrl = pPicture;
    user.role = ['shop'];
  }

  /// Registrar en firebase auth
  signUp() async {
    signUpResult = await auth.signUp(
      email: emailController.text,
      password: passController.text,
    );
  }

  /// Valida la respuesta de frebase auth
  validateAndSignUp() async {
    switch (signUpResult) {
      case 'There is an account already registered with this email.':
        CustomSnackBars.showErrorSnackBar(
            'Ya existe un usuario con este correo.');
        isLoading.value = false;
        break;
      case 'Your email address appears to be malformed.':
        CustomSnackBars.showErrorSnackBar('Tu correo está mal escrito');
        break;
    }
    if (signUpResult is String) {
      CustomSnackBars.showErrorSnackBar(signUpResult);
      isLoading.value = false;
      return;
    }
  }

  /// Valida si tiene o no foto para subirla
  validateProfilePicture() async {
    if (bytesFromPicker != null) {
      final urlRutResult = await storageService.uploadFile(
        signUpResult.user.uid,
        'FotoPerfil',
        bytesFromPicker!,
      );
      print(urlRutResult);

      assignUser(urlRutResult!);
    } else {
      assignUser('');
    }
  }

  /// Guarda el usuario en firebase
  saveUserInFirebase() async {
    final result = await userService.save(
      user: user,
      customId: signUpResult.user.uid,
    );
    if (result) {
      Get.offAllNamed(Routes.HOME);
    } else {
      CustomSnackBars.showErrorSnackBar(
        'Error al crear el usuario, por favor intenta de nuevo',
      );
    }
  }

  /// Registra al usuario
  register() async {
    if (!terms.value) {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, acepta los términos y condiciones y políticas de privacidad',
      );
    } else if (key.currentState!.validate()) {
      try {
        isLoading.value = true;
        await signUp();
        await validateAndSignUp();
        await validateProfilePicture();
        await saveUserInFirebase();

        isLoading.value = false;
      } catch (e) {
        print(e.toString());
        await auth.deleteUser();
        CustomSnackBars.showErrorSnackBar(
          'Error al crear el usuario, por favor intenta de nuevo',
        );
        isLoading.value = false;
      }
    }
  }

  showPicker() async {
    isLoadingPP.value = true;
    bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    isLoadingPP.value = false;
  }
}
