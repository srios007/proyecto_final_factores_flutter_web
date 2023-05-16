import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:proyecto_final_factores_flutter_web/app/utils/utils.dart';
import 'package:proyecto_final_factores_flutter_web/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', '')],
      useInheritedMediaQuery: true,
      title: 'Application',
      initialRoute: _setInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Palette.mainBlue),
          elevation: 0,
        ),
      ),
    );
  }

  String _setInitialRoute() {
    // final firebaseUser = auth.getCurrentUser();
    // if (firebaseUser != null) {
      return Routes.HOME;
    // } else {
    //   return Routes.LOGIN;
    // }
  }
}

