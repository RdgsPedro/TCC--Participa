import 'package:participa/data/datasources/newsDatasource/news_remote_datasource.dart';
import 'package:participa/domain/entities/newsEntity/news_entity.dart';
import 'package:participa/domain/repositories/newsRepository/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl([NewsRemoteDataSource? dataSource])
    : remoteDataSource = dataSource ?? FakeNewsRemoteDataSource();

  @override
  Future<List<NewsEntity>> getNews() {
    return remoteDataSource.fetchNews();
  }
}
