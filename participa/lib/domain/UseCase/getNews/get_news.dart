import 'package:participa/domain/entities/newsEntity/news_entity.dart';
import 'package:participa/domain/repositories/newsRepository/news_repository.dart';

class GetNews {
  final NewsRepository repository;
  GetNews(this.repository);

  Future<List<NewsEntity>> call() async {
    return await repository.getNews();
  }
}
