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
            controller: controller.scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children:   [
                  Form(
                    key: controller.formKeyLogin,
                    child: SizedBox(
                      height: Get.height,
                      width: Get.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Rutapp',
                            style: TextStyle(
                                color: Palette.mainBlue,
                                fontSize: 42,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: EmailInput(
                              hintText: 'example@lizit.app',
                              textEditingController: controller.emailController,
                              titleText: 'Email',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 80),
                            child: PasswordInput(
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
