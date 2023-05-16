import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/palette.dart';

class ImagePickAlert {
  profilePictureAlert({
    required BuildContext context,
    required void Function() fromPhoto,
    required void Function() fromGallery,
    File? image,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <Widget>[
          Itembutton(
            onPressed: fromPhoto,
            label: 'Tomar una foto     ',
            icon: const Icon(
              Icons.camera_alt,
              color: Palette.mainBlue,
            ),
          ),
          Itembutton(
            onPressed: fromGallery,
            label: 'Desde galería      ',
            icon: const Icon(
              Icons.photo_album,
              color: Palette.mainBlue,
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: Get.back,
          child: const Text(
            'Cancelar',
            style: TextStyle(
              color: Palette.mainBlue,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

ImagePickAlert imagePickAlert = ImagePickAlert();

class Itembutton extends StatelessWidget {
  const Itembutton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  final void Function()? onPressed;
  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: Palette.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: icon,
          ),
          Text(
            label,
            style: const TextStyle(
              color: Palette.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
