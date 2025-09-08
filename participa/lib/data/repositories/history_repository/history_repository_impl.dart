import 'package:participa/domain/entities/history_entity/history_entity.dart';
import 'package:participa/data/datasources/history_datasource/history_remote_data_source.dart';
import 'package:participa/domain/repositories/history_repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource dataSource;
  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<List<HistoryEntity>> getHistory() async {
    final models = await dataSource.getHistory();
    return models;
  }
}
