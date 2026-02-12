import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/app_colors.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void  main () async {
  // runApp(const SocialVibeApp());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
