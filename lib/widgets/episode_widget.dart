import 'package:flutter/material.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EpisodeWiget extends StatelessWidget {


  const EpisodeWiget({
    super.key,
    required this.episode,
    required this.webtoonId
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode;

  onButtonTap() async {
    // final url = Uri.parse('https://google.com');
    // launchUrl(url);

    // ==> 변경1.
    // launchUrlString('https://google.com');

    // ==> 변경2. 받아와서 네이버웹툰으로.
    var uri = 'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}';
    launchUrlString(uri);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green.shade400,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title, style: TextStyle(
                color: Colors.white
              )),
              Icon(Icons.chevron_right_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}