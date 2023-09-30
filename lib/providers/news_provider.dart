import 'package:crypto_currency_tracker_and_news/models/News.dart';
import 'package:flutter/cupertino.dart';
import '../services/API.dart';

class NewsProvider with ChangeNotifier {
  bool isLoading = true;
  List<News> news = [];

  NewsProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _news = await API.getNews();

    List<News> temp = [];
    for (var n in _news) {
      News newNews = News.fromJSON(n);
      temp.add(newNews);
    }
    news = temp;
    isLoading = false;
    notifyListeners();
  }
}
