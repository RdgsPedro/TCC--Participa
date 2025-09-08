import 'package:participa/domain/entities/history_entity/history_entity.dart';
import 'package:participa/domain/repositories/history_repository/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;
  GetHistory(this.repository);

  Future<List<HistoryEntity>> call({String? type}) async {
    final all = await repository.getHistory();
    if (type == null || type.isEmpty || type == 'todos') return all;
    return all.where((e) => e.type == type).toList();
  }
}
