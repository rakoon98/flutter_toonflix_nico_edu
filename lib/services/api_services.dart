import 'dart:convert';

import 'package:flutter_toonflix_nico_edu/models/webtoon_detail_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_episode_model.dart';
import 'package:flutter_toonflix_nico_edu/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";

  static const String today = "today";


  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonList = [];

    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // future 가 기다렸다가 reponse 로 내려줄것.
    if(response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);

      for(var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonList.add(toon);
      }

      return webtoonList;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

   static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(String id) async {
    List<WebtoonEpisodeModel> list = [];

    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if(response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for(var episode in episodes) {
        list.add(WebtoonEpisodeModel.fromJson(episode));  
      }

      return list;
    }
    throw Error();
  }
}