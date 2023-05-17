import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_product_controller.dart';

class RegisterProductView extends GetView<RegisterProductController> {
  const RegisterProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegisterProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
