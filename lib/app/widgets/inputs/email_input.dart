import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/app/widgets/widgets.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    super.key,
    required this.titleText,
    required this.hintText,
    required this.textEditingController,
    this.helperText = '',
    this.border,
    this.textStyle,
 
  });

  String titleText;
  String hintText;
  String helperText;
  TextEditingController textEditingController;
  InputBorder? border;
  TextStyle? textStyle;
 

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
          SizedBox(
            width: ResponsiveWidget.isSmallScreen(Get.context!)
                      ? Get.width
                      : Get.width * 0.6,
            child: TextFormField(
              style: textStyle,
              decoration: InputDecoration(
                helperText: helperText,
                hintText: hintText,
                errorStyle: styles.errorStyle,
                enabledBorder: styles.borderTextField,
                focusedBorder: styles.borderTextField,
                errorBorder: styles.borderTextField,
                focusedErrorBorder: styles.borderTextField,
              ),
              controller: textEditingController,
              validator: (String? _) {
                if (textEditingController.text.isEmpty) {
                  return 'Por favor, rellena este campo';
                } else if (!GetUtils.isEmail(textEditingController.text)) {
                  return 'Ingresa un email válido';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
            ),
          ),
        ],
      ),
    );
  }
}
