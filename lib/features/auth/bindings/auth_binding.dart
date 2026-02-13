import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../controllers/register_controller.dart';
import '../controllers/otp_controller.dart'; // if you have it

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Login
    Get.put<LoginController>(
      LoginController(),
      permanent: true, // keep if you really want it always in memory
    );

    // Register
    Get.lazyPut<RegisterController>(
          () => RegisterController(),
      fenix: true, // recreates if disposed
    );

    // OTP
    Get.lazyPut<OtpController>(
          () => OtpController(),
      fenix: true,
    );
  }
}