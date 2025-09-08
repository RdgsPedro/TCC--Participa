import 'package:participa/domain/entities/history_entity/history_entity.dart';

abstract class HistoryRepository {
  Future<List<HistoryEntity>> getHistory();
}
