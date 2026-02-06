import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const SocialVibeApp());
}

class SocialVibeApp extends StatelessWidget {
  const SocialVibeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SocialVibe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: false,
      ),
      initialRoute: AppRoutes.welcome, // first screen
      getPages: AppPages.routes,
    );
  }
}
