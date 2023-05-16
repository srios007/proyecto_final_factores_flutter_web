import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';

class NormalInput extends StatelessWidget {
  NormalInput({
    super.key,
    required this.hintText,
    required this.titleText,
    required this.textEditingController,
    this.helperText = '',
    this.validator,
    this.color,
    this.hintColor,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.keyboardType,
    this.textCapitalization,
    this.inputFormatters,
  });

  String hintText;
  String helperText;
  TextEditingController textEditingController;
  String? Function(String?)? validator;
  Color? color;
  Color? hintColor;
  InputBorder? enabledBorder;
  InputBorder? focusedBorder;
  InputBorder? errorBorder;
  InputBorder? focusedErrorBorder;
  TextInputType? keyboardType;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width - 60,
                child: TextFormField(
                  textCapitalization:
                      textCapitalization ?? TextCapitalization.none,
                  inputFormatters: inputFormatters ?? [],
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
            ],
          ),
        ],
      ),
    );
  }
}
