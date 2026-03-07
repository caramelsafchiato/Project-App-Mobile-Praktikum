import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/constants.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
// import 'core/theme/theme.dart'; 

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      // Jika AppTheme belum dibuat, kamu bisa mengomentari baris theme di bawah ini
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const DashboardPage(),
    );
  }
}