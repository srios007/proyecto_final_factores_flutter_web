import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/login/controllers/login_controller.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: WebScrollbar(
          color: Colors.white,
          backgroundColor: Colors.white,
          heightFraction: 0.3,
          controller: controller.scrollController,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: controller.formKeyLogin,
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        titleSection(),
                        const SizedBox(height: 50),
                        imputsSection(context),
                        buttonLabelSection()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  buttonLabelSection() {
    return Column(
      children: [
        CustomButton(
          isLoading: controller.isLoading,
          onPressed: controller.login,
          buttonText: 'Ingresar',
          width: 300,
        ),
        const SizedBox(height: 30),
        registerLabel(),
        const SizedBox(height: 30),
      ],
    );
  }

  imputsSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: EmailInput(
            hintText: 'example@udistrital.app',
            textEditingController: controller.emailController,
            titleText: 'Email',
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: PasswordInput(
            hintText: 'Contraseña',
            showPassword: controller.visiblePassword,
            showPasswordAction: controller.showPassword,
            textEditingController: controller.passwordController,
            titleText: 'Escribe tu contraseña',
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Text titleSection() {
    return const Text(
      'Empresas',
      style: TextStyle(
          color: Palette.mainBlue, fontSize: 42, fontWeight: FontWeight.bold),
    );
  }

  /// Label de regístrate
  registerLabel() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: controller.goToRegister,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿No tienes una cuenta? ',
              style: TextStyle(
                color: Palette.mainBlue,
                fontSize:
                    ResponsiveWidget.isSmallScreen(Get.context!) ? 14 : 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'Regístrate',
              style: TextStyle(
                color: Palette.mainBlue,
                fontSize:
                    ResponsiveWidget.isSmallScreen(Get.context!) ? 14 : 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
