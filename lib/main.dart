import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Make status bar dark-mode friendly
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const VentApp());
}

class VentApp extends StatelessWidget {
  const VentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vent',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,          // we will create this next
      home: const HomeScreen(),
    );
  }
}