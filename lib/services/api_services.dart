import 'dart:convert';

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
}