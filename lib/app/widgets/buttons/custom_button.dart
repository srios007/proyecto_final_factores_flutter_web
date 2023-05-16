import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/palette.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.buttonText,
    required this.isLoading,
    required this.onPressed,
    this.icon,
    this.width,
    this.height,
    this.fontSize,
    this.color,
    this.colorText,
    this.iconStart,
    this.borderRadius,
    this.borderColor,
    this.fontWeight,
    this.elevation,
  });

  RxBool isLoading;
  String? buttonText;
  Widget? icon;
  bool? iconStart;
  void Function() onPressed;
  double? width;
  double? height;
  double? fontSize;
  Color? color;
  Color? colorText;
  double? borderRadius;
  Color? borderColor;
  FontWeight? fontWeight;
  double? elevation;

  @override
  Widget build(BuildContext context) {
    iconStart ??= false;
    return Obx(
      () => SizedBox(
        width: width ?? Get.width - 60,
        height: height ?? 55,
        child: MaterialButton(
          color: color ?? Palette.mainBlue,
          elevation: elevation ?? 1,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
          ),
          onPressed: isLoading.value ? () {} : onPressed,
          child: isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Palette.white,
                    ),
                  ),
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconStart! ? icon! : const SizedBox(),
                        iconStart!
                            ? const SizedBox(
                                width: 8,
                              )
                            : const SizedBox(),
                        Text(
                          buttonText ?? 'Continuar',
                          style: TextStyle(
                              color: colorText ?? Palette.white,
                              fontSize: fontSize ?? 18,
                              fontWeight: fontWeight ?? FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                        iconStart! == false
                            ? const SizedBox(
                                width: 8,
                              )
                            : const SizedBox(),
                        iconStart! == false ? icon! : const SizedBox(),
                      ],
                    )
                  : Text(
                      buttonText ?? 'Continuar',
                      style: TextStyle(
                          color: colorText ?? Palette.white,
                          fontSize: fontSize ?? 18,
                          fontWeight: fontWeight ?? FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
        ),
      ),
    );
  }
}
