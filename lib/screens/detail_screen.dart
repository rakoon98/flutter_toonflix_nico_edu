import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';

class DetailScreen extends StatelessWidget {
  final WebtoonModel webtoonModel;
  const DetailScreen({super.key, required this.webtoonModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1, // 앱바의 음영
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: Text(
          webtoonModel.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 250,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: Offset(10, 10),
                      color: Colors.black38,
                    ),
                  ],
                ),
                child: Image.network(webtoonModel.thumb),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
