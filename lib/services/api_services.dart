import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";

  final String today = "today";


  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url); // future 가 기다렸다가 reponse 로 내려줄것.
    if(response.statusCode == 200) {
      print(response.body);
    }
    throw Error();
  }
}