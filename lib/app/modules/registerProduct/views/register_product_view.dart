import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/registerProduct/controllers/register_product_controller.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class RegisterProductView extends GetView<RegisterProductController> {
  const RegisterProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Palette.mainBlue,
              elevation: 0,
              centerTitle: true,
              title: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  // setState(() {
                  // page = 0;
                  // });
                },
                child: Container(),
              ),
            )
          : PreferredSize(
              preferredSize: Size(Get.width, 1000),
              child: TopBarContents(),
            ),
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
    return Column(
      children: [
        Text(
          'Registrar un nuevo producto',
          style: TextStyle(
            color: Palette.mainBlue,
            fontSize: ResponsiveWidget.isSmallScreen(Get.context!) ? 20 : 32,
            fontWeight: ResponsiveWidget.isSmallScreen(Get.context!)
                ? FontWeight.w300
                : FontWeight.bold,
          ),
        ),
        const SizedBox(height: 50),
        GestureDetector(
          onTap: () {
            controller.showPicker();
          },
          child: Obx(
            () {
              return controller.isLoadingPP.value
                  ? noPhoto()
                  : controller.bytesFromPicker != null
                      ? withPhoto()
                      : noPhoto();
            },
          ),
        ),
      ],
    );
  }

  /// Container cuando el usuario sube una foto
  withPhoto() {
    return Container(
      width: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 470,
      height: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 470,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Palette.mainBlue,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
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
              width: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 470,
              height: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 470,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Palette.mainBlue,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.image,
                size: ResponsiveWidget.isSmallScreen(Get.context!) ? 30 : 100,
                color: Palette.mainBlue,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 40,
              height: ResponsiveWidget.isSmallScreen(Get.context!) ? 100 : 40,
              decoration: BoxDecoration(
                color: Palette.mainBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.mainBlue,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Palette.white,
                size: 15,
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
            titleText: 'Descripción',
            hintText: 'Escribe la descripción de tu producto',
            textEditingController: controller.descController,
            maxLines: 5,
          ),
          const SizedBox(height: 25),
          NormalInput(
            titleText: 'Precio',
            hintText: 'Escribe tu precio',
            textEditingController: controller.priceController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
              TextInputFormatter.withFunction(
                (oldValue, newValue) => newValue.copyWith(
                  text: newValue.text.replaceAll('.', ','),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Botón que inicia sesión
  registerButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        width: 300,
        isLoading: controller.isLoadingBut,
        onPressed: controller.register,
        buttonText: 'Guardar',
      ),
    );
  }
}
