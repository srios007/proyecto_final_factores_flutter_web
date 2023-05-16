import 'package:get/get.dart';

import 'package:proyecto_final_factores_flutter_web/app/modules/home/bindings/home_binding.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/home/views/home_view.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/login/bindings/login_binding.dart';
import 'package:proyecto_final_factores_flutter_web/app/modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
