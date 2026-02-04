import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const CignifiApp());
}

class CignifiApp extends StatelessWidget {
  const CignifiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cignifi Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: false,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,
    );
  }
}
