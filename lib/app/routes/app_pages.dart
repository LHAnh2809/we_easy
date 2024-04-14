import 'package:get/get.dart';

import '../modules/auth/bindings/auth_bindings.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/view/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/view/splash_view.dart';
import '../modules/welcome/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  const AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.splash,
      transition: Transition.rightToLeftWithFade,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.welcome,
      transition: Transition.rightToLeftWithFade,
      page: () => const WelcomeView(),
    ),
    GetPage(
      name: _Paths.auth,
      transition: Transition.rightToLeftWithFade,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
  ];
}
