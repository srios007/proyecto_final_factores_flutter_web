import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class LoginController extends GetxController {
  ScrollController scrollController = ScrollController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  RxBool visiblePassword = false.obs;
  RxDouble scrollPosition = 0.0.obs;
  RxBool isLoading = false.obs;
  final count = 0.obs;
  double opacity = 0;


  /// Oculta o muestra la contraseña del usuario
  void showPassword() {
    visiblePassword.value = !visiblePassword.value;
  }

  scrollListener() {
    print(
      'scrollController.position.pixels: ${scrollController.position.pixels}',
    );
  }

  login() async {
    if (formKeyLogin.currentState!.validate()) {
      isLoading.value = true;
      try {
        final response = await auth.signIn(
            email: emailController.text.trim(),
            password: passwordController.text);
        if (response is! String) {
          isLoading.value = false;
          final result = await userService.validateLogin();
          if (result) {
            Get.offAllNamed(Routes.HOME);
          } else {
            CustomSnackBars.showErrorSnackBar(
              'No tienes acceso a esta plataforma',
            );
          }
        } else {
          CustomSnackBars.showErrorSnackBar(response);
          isLoading.value = false;
        }
      } catch (e) {
        e.toString();
      }
    }
  }
}
