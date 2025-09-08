import 'package:participa/domain/entities/newsEntity/news_entity.dart';

abstract class NewsRepository {
  Future<List<NewsEntity>> getNews();
}
