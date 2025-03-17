import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:flutter_toonflix_nico_edu/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<WebtoonModel> webtoonList = [];
  bool isLoading = true;

  void waitForWebtoons() async {
    webtoonList = await ApiServices.getTodaysToons();
    isLoading = false;

    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
    waitForWebtoons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1, // 앱바의 음영
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600
          )
        )
      ),
    );
  }
}