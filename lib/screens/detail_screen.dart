import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_episode_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:flutter_toonflix_nico_edu/services/api_services.dart';
import 'package:flutter_toonflix_nico_edu/widgets/episode_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoonModel;
  const DetailScreen({super.key, required this.webtoonModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;

  late SharedPreferences pref;
  bool isLiked = false;
  final String LIKE_TOONS_KEY = 'likeToons';

  Future initPref() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList(LIKE_TOONS_KEY);

    if (likedToons != null) {
      setState(() {
        isLiked = likedToons.contains(widget.webtoonModel.id) == true;
      });
    } else {
      await pref.setStringList(LIKE_TOONS_KEY, []);
    }
  }

  @override
  void initState() {
    super.initState();
    webtoon = ApiServices.getToonById(widget.webtoonModel.id);
    episodes = ApiServices.getLatestEpisodesById(widget.webtoonModel.id);

    initPref();
  }

  onHeartTap() async {
    final likedToons = pref.getStringList(LIKE_TOONS_KEY);
    
    if(likedToons != null) {
      if(isLiked) {
        likedToons.remove(widget.webtoonModel.id);
      } else {
        likedToons.add(widget.webtoonModel.id);
      }

      await pref.setStringList(LIKE_TOONS_KEY, likedToons);

      setState(() {
        isLiked = !isLiked;
      });
    }
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
        actions: [
          IconButton(
            onPressed: onHeartTap,
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
          ),
        ],
        title: Text(
          widget.webtoonModel.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
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
                    return Column(
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
                    );
                  }
                  return Text('...');
                },
              ),
              SizedBox(height: 50),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    var list = data.take(10);

                    return Column(
                      children: [
                        for (var episode in list)
                          EpisodeWiget(
                            episode: episode,
                            webtoonId: widget.webtoonModel.id,
                          ),
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
