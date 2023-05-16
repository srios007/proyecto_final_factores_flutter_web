import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/login/controllers/login_controller.dart';
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
              children: const [],
            ),
          ),
        ),
      ),
    );
  }
}
