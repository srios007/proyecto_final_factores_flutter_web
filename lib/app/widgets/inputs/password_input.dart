import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    super.key,
    required this.hintText,
    required this.titleText,
    required this.showPassword,
    required this.textEditingController,
    required this.showPasswordAction,
    this.helperText = '',
    this.validator,
    this.keyboardType,
    this.textCapitalization,
  });

  String hintText;
  String helperText;
  TextEditingController textEditingController;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  TextCapitalization? textCapitalization;
  RxBool showPassword = false.obs;
  VoidCallback? showPasswordAction;
  String titleText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleText,
            style: const TextStyle(
              color: Palette.mainBlue,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Obx(
            () => SizedBox(
              width:ResponsiveWidget.isSmallScreen(Get.context!)
                      ? Get.width
                      : Get.width * 0.6,
              child: TextFormField(
                obscureText: !showPassword.value,
                textCapitalization: textCapitalization ?? TextCapitalization.none,
                decoration: InputDecoration(
                    helperText: helperText,
                    hintText: hintText,
                    errorStyle: styles.errorStyle,
                    enabledBorder: styles.borderTextField,
                    focusedBorder: styles.borderTextField,
                    errorBorder: styles.borderTextField,
                    focusedErrorBorder: styles.borderTextField,
                    suffixIcon: IconButton(
                      onPressed: showPasswordAction,
                      icon: showPassword.value
                          ? const Icon(CupertinoIcons.eye,
                              color: Palette.mainBlue)
                          : const Icon(CupertinoIcons.eye_slash,
                              color: Palette.mainBlue),
                    )),
                controller: textEditingController,
                validator: validator ??
                    (String? _) {
                      if (textEditingController.text.isEmpty) {
                        return 'Por favor, rellena este campo';
                      } else {
                        return null;
                      }
                    },
                keyboardType: keyboardType ?? TextInputType.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
