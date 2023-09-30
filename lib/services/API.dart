import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (ex) {
      print(ex.toString());
      return [];
    }
  }

  static Future<List<dynamic>> getNews() async {
    try {
      Uri requestPath = Uri.parse(
          "https://newsapi.org/v2/everything?q=crypto&from=2023-08-30&sortBy=publishedAt&apiKey=e7615d1c8e0341a784b178a2cdc7e3ce");

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      // Check if the JSON response contains an "articles" key and it's a list
      if (decodedResponse.containsKey("articles") &&
          decodedResponse["articles"] is List) {
        List<dynamic> news = decodedResponse["articles"];
        return news;
      } else {
        print(
            "Invalid JSON structure: Missing 'articles' key or it's not a list.");
        return [];
      }
    } catch (ex) {
      print(ex.toString());
      return [];
    }
  }
}
