import 'package:flutter/material.dart';
import 'features/dashboard/dashboard_screen.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        cardColor: const Color(0xFF1A1A1D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D0D0F),
          elevation: 0,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}