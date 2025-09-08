import 'package:flutter/material.dart';
import 'package:participa/domain/UseCase/getNews/get_news.dart';
import 'package:participa/domain/entities/newsEntity/news_entity.dart';

class NewsController extends ChangeNotifier {
  final GetNews _getNews;
  NewsController(this._getNews);

  List<NewsEntity> items = [];
  bool loading = false;
  String? error;
  int currentIndex = 0;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      items = await _getNews();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void setIndex(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
