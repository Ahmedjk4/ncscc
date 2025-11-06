import 'package:flutter/material.dart';
import 'package:ncss_code_club/utils/app_router.dart';
import 'package:ncss_code_club/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NCSCC',
      theme: AppTheme().themeData,
      routerConfig: AppRouter.router,
    );
  }
}
