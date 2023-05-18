import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/register/controllers/register_controller.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    profilePicture(),
                    const SizedBox(height: 30),
                    inputsSection(),
                    checksAcceptAndButtonSection(),
                    const SizedBox(height: 20),
                    const Spacer(flex: 2),
                    registerButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  profilePicture() {
    return GestureDetector(onTap: () {
      controller.showPicker();
    }, child: Obx(
      () {
        return controller.isLoadingPP.value
            ? noPhoto()
            : controller.bytesFromPicker != null
                ? withPhoto()
                : noPhoto();
      },
    ));
  }

  /// Container cuando el usuario sube una foto
  withPhoto() {
    return Container(
      width: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 480,
      height: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 480,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Palette.mainBlue,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.memory(
          controller.bytesFromPicker!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Container cuando el usuario no tiene foto
  noPhoto() {
    return SizedBox(
      height: ResponsiveWidget.isSmallScreen(Get.context!) ? 120 : 500,
      width: ResponsiveWidget.isSmallScreen(Get.context!) ? 120 : 500,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 480,
              height: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.mainBlue,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person_rounded,
                size: ResponsiveWidget.isSmallScreen(Get.context!) ? 30 : 100,
                color: Palette.mainBlue,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal:
                    ResponsiveWidget.isSmallScreen(Get.context!) ? 10 : 50,
                vertical:
                    ResponsiveWidget.isSmallScreen(Get.context!) ? 15 : 55,
              ),
              width: ResponsiveWidget.isSmallScreen(Get.context!) ? 25 : 50,
              height: ResponsiveWidget.isSmallScreen(Get.context!) ? 25 : 50,
              decoration: BoxDecoration(
                color: Palette.mainBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.mainBlue,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.add,
                color: Palette.white,
                size: ResponsiveWidget.isSmallScreen(Get.context!) ? 15 : 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Capos de textt (correo y contraseña)
  inputsSection() {
    return Form(
      key: controller.key,
      child: Column(
        children: [
          NormalInput(
            titleText: 'Nombre',
            hintText: 'Escribe tu nombre',
            textEditingController: controller.nameController,
          ),
          const SizedBox(height: 25),
          NormalInput(
            titleText: 'Apellido',
            hintText: 'Escribe tu apellido',
            textEditingController: controller.lastnameController,
          ),
          const SizedBox(height: 25),
          EmailInput(
            titleText: 'Correo',
            hintText: 'Escribe tu correo',
            textEditingController: controller.emailController,
          ),
          const SizedBox(height: 25),
          PasswordInput(
            titleText: 'Contraseña',
            hintText: 'Escribe tu contraseña',
            textEditingController: controller.passController,
            showPassword: controller.showPass,
            showPasswordAction: controller.showPassword,
            validator: (String? _) {
              if (controller.passController.text.isEmpty) {
                return 'Por favor, rellena este campo';
              } else if (controller.passController.text !=
                  controller.confPassController.text) {
                return 'Las contraseñas no coinciden';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 25),
          PasswordInput(
            titleText: 'Confirmar contraseña',
            hintText: 'Escribe tu contraseña',
            textEditingController: controller.confPassController,
            showPassword: controller.showConfPass,
            showPasswordAction: controller.showConfPassword,
            validator: (String? _) {
              if (controller.confPassController.text.isEmpty) {
                return 'Por favor, rellena este campo';
              } else if (controller.passController.text !=
                  controller.confPassController.text) {
                return 'Las contraseñas no coinciden';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  /// Check de términos y botón
  checksAcceptAndButtonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Obx(
          () => CheckAccept(
            label: 'Términos y Condiciones',
            label2: 'Políticas de Privacidad',
            value: controller.terms,
            onChanged: controller.onChangedT,
            onTap: controller.goToTerms,
            onTap2: controller.goToPolicies,
            color:
                !controller.terms.value ? Palette.mainBlue : Palette.mainBlue,
          ),
        ),
      ],
    );
  }

  /// Botón que inicia sesión
  registerButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        width: 300,
        isLoading: controller.isLoading,
        onPressed: controller.register,
        buttonText: 'Registrarme',
      ),
    );
  }
}
