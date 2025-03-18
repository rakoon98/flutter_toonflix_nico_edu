import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/screens/home_screen.dart';
import 'package:flutter_toonflix_nico_edu/util/MyHttpOverrides.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides(); // 글로벌하게 헤더 바꾸는 방법.

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