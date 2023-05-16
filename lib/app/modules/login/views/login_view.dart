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
                        const Text(
                          'Empresas',
                          style: TextStyle(
                              color: Palette.mainBlue,
                              fontSize: 42,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: EmailInput(
                            width: Get.width * 0.6,
                            hintText: 'example@udistrital.app',
                            textEditingController: controller.emailController,
                            titleText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: PasswordInput(
                            width: Get.width * 0.6,
                            hintText: 'Contraseña',
                            showPassword: controller.visiblePassword,
                            showPasswordAction: controller.showPassword,
                            textEditingController:
                                controller.passwordController,
                            titleText: 'Escribe tu contraseña',
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          isLoading: controller.isLoading,
                          onPressed: controller.login,
                          buttonText: 'Ingresar',
                          width: 300,
                        )
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
}
