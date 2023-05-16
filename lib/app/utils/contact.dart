import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LizitContact {
  static void launchWhatsApp() async {
    await canLaunchUrl(Uri.parse('https://wa.me/3118265625'))
        ? launchUrl(Uri.parse('https://wa.me/3118165625'),
            mode: LaunchMode.externalApplication)
        : showDialog(
            context: Get.context!,
            builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              backgroundColor: Colors.white,
              child: const Text('No se pudo abrir wha'),
            ),
          );
  }

  static void launchWhatsAppWithMessage({
    required String phoneNumber,
    required String message,
  }) async {
    await canLaunchUrl(Uri.parse('https://wa.me/$phoneNumber?text=$message'))
        ? launchUrl(Uri.parse('https://wa.me/$phoneNumber?text=$message'),
            mode: LaunchMode.externalApplication)
        : showDialog(
            context: Get.context!,
            builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 8,
              backgroundColor: Colors.white,
              child: const Text('No se pudo abrir wha'),
            ),
          );
  }
}
