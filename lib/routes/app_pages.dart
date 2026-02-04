import 'package:get/get.dart';

import '../features/auth/controllers/register_controller.dart';
import '../features/auth/views/register_screen.dart';
import '../features/auth/controllers/login_controller.dart';
import '../features/auth/views/login_screen.dart';
import '../features/auth/controllers/otp_controller.dart';
import '../features/auth/views/otp_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: BindingsBuilder(() {
        Get.put(RegisterController());
      }),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: BindingsBuilder(() {
        Get.put(OtpController());
      }),
    ),
  ];
}
