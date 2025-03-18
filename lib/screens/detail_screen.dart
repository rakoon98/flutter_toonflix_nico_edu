import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_episode_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:flutter_toonflix_nico_edu/services/api_services.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoonModel;
  const DetailScreen({super.key, required this.webtoonModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiServices.getToonById(widget.webtoonModel.id);
    episodes = ApiServices.getLatestEpisodesById(widget.webtoonModel.id);
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
        title: Text(
          widget.webtoonModel.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.webtoonModel.id,
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
                  child: Image.network(widget.webtoonModel.thumb),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.about,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '${snapshot.data!.genre} / ${snapshot.data!.age}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }
              return Text('...');
            },
          ),
        ],
      ),
    );
  }
}
