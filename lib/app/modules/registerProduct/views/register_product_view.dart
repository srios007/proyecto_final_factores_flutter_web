import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

import '../controllers/register_product_controller.dart';

class RegisterProductView extends GetView<RegisterProductController> {
  const RegisterProductView({Key? key}) : super(key: key);
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
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
