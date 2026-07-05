import 'package:flutter/material.dart';

import '../features/home/presentation/home_screen.dart';
import 'app_theme.dart';

class HistoricalGuidanceApp extends StatelessWidget {
  const HistoricalGuidanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Historical Guidance',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
