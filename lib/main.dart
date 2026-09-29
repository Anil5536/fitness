import 'package:flutter/material.dart';

import 'core/colors.dart';
import 'screens/onboarding/splash_screen.dart';
import 'screens/onboarding/welcome_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const RoutinelyApp());
}

class RoutinelyApp extends StatelessWidget {
  const RoutinelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Routinely',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.yellow,
          surface: AppColors.bg,
        ),
      ),
      home: SplashScreen(
        onFinished: () => navigatorKey.currentState!.pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        ),
      ),
    );
  }
}
