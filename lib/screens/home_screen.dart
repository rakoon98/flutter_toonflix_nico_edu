import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:flutter_toonflix_nico_edu/services/api_services.dart';
import 'package:flutter_toonflix_nico_edu/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiServices.getTodaysToons();

  //## 1차 학습
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
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          // snapshot: future의 상태
          if (snapshot.hasData) {
            // return ListView(
            //   children: [
            //     for(var webtoon in snapshot.data!)
            //     Text(webtoon.title)
            //   ],
            // );

            // // 1차 개선
            // return ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     var webtoon = snapshot.data![index];
            //     return Text(webtoon.title);
            //   },
            // );

            // 2차 개선 - column 은 listview 가 얼마나 높은지 알지 못함.
            return Column(
              children: [
                SizedBox(height: 50),
                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonWidget(webtoonModel: webtoon);
      },
      separatorBuilder: (context, index) {
        return SizedBox(width: 40);
      },
    );
  }
}
