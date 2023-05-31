import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/models.dart';
import 'package:proyecto_final_factores_flutter_web/app/models/purchase_model.dart';

import 'package:proyecto_final_factores_flutter_web/app/modules/my_sales/controllers/my_sales_controller.dart';
import 'package:proyecto_final_factores_flutter_web/app/services/services.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class MySalesView extends GetView<MySalesController> {
  const MySalesView({super.key});
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
                onPressed: () {},
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
              titleSection(),
              productsSection(),
            ],
          ),
        ),
      ),
    );
  }

  titleSection() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? const SizedBox.shrink()
                  : Text(
                      'Bienvenido ${controller.user.name}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          color: Palette.mainBlue),
                    ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Mis ventas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  productsSection() {
    return Obx(
      () => controller.isLoading.value
          ? loadingWidget()
          : controller.products.isEmpty
              ? noResults()
              : productsGrid(),
    );
  }

  productsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.7,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: controller.products.length,
          (BuildContext context, int index) {
            final product = controller.products[index];
            return productItem(product);
          },
        ),
      ),
    );
  }

  productItem(Purchase purchase) {
    return GestureDetector(
      onTap: () {
        // controller.goToProductDetail(product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.none,
                  imageUrl: purchase.productUrl!,
                  width: Get.width,
                  height: Get.height * 0.2,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Palette.mainBlue,
                        rightDotColor: Palette.green,
                        size: 20,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const Spacer(),
              Text(
                purchase.productName!,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Spacer(),
              Text(
                'Estado: ${purchase.state!}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    width: Get.width * 0.06,
                    isLoading: false.obs,
                    color: purchase.state == 'Enviado' ||
                            purchase.state == 'Entregado'
                        ? Colors.grey
                        : Palette.mainBlue,
                    onPressed: () {
                      if (purchase.state == 'Enviado' ||
                          purchase.state == 'Entregado') {
                        CustomSnackBars.showErrorSnackBar(
                          'No puedes devolver el estado',
                        );
                      } else {
                        controller.changeState(purchase, 'Enviado');
                      }
                    },
                    buttonText: 'Cambiar a enviado',
                  ),
                  CustomButton(
                    width: Get.width * 0.06,
                    isLoading: false.obs,
                    color: purchase.state == 'Entregado'
                        ? Colors.grey
                        : Palette.mainBlue,
                    onPressed: () {
                      if (purchase.state == 'Entregado') {
                        CustomSnackBars.showErrorSnackBar(
                          'No puedes devolver el estado',
                        );
                      } else {
                        controller.changeState(purchase, 'Entregado');
                      }
                    },
                    buttonText: 'Cambiar a Entregado',
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  noResults() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text('Sin resultados'),
      ),
    );
  }

  loadingWidget() {
    return const SliverToBoxAdapter(
      child: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
