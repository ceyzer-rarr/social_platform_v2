import 'package:get/get.dart';

import '../features/auth/views/login_screen.dart';
import '../features/auth/views/otp_screen.dart';
import '../features/auth/views/register_screen.dart';
import '../features/auth/views/welcome_screen.dart';
import '../features/main/controllers/main_shell_controller.dart';
import '../features/main/views/main_shell_screen.dart';
import '../features/profile/controllers/profile_controller.dart';
import '../features/profile/controllers/profile_edit_controller.dart';
import '../features/profile/views/profile_edit_screen.dart';
import '../features/auth/bindings/auth_binding.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    // ---------- AUTH FLOW ----------
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(), // provides LoginController etc.
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(), // same binding, reused
    ),

    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
      binding: AuthBinding(), // same binding, reused
    ),

    // ---------- MAIN APP ----------
    GetPage(
      name: AppRoutes.main,
      page: () => const MainShellScreen(),
      binding: BindingsBuilder(() {
        Get.put(MainShellController());
        Get.put(ProfileController());
      }),
    ),

    GetPage(
      name: AppRoutes.profileEdit,
      page: () => const ProfileEditScreen(),
      binding: BindingsBuilder(() {
        Get.put(ProfileEditController());
      }),
    ),
  ];
}
