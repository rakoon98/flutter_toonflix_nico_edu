import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/screens/home_screen.dart';
import 'package:flutter_toonflix_nico_edu/services/api_services.dart';

void main() {
  // 임시
  ApiServices().getTodaysToons();
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen()
    );
  }
}