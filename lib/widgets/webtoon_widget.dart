import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:flutter_toonflix_nico_edu/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final WebtoonModel webtoonModel;

  const WebtoonWidget({super.key, required this.webtoonModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
          
            builder: (context) => DetailScreen(webtoonModel: webtoonModel),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: webtoonModel.id,
            child: Container(
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
              child: Image.network(
                webtoonModel.thumb,
            
                // 에러의 원인
            
                // 따로 User-Agent 값을 추가하지 않으면 기본값으로 `Dart/<version> (dart:io)` 가 들어갑니다.
                // (https://api.flutter.dev/flutter/dart-io/HttpClient/userAgent.html)
            
                // 이 값을 지우고 브라우저에서 사용하는 값으로 바꿔줍니다.
                // (브라우저 값이 아니면 네이버에서 차단하는걸로 보입니다)
                // 이 한곳에 헤더 바꾸는방법.
                // headers: const {"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",},
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(webtoonModel.title, style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
