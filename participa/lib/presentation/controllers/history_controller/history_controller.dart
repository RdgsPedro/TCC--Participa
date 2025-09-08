import 'package:flutter/material.dart';
import 'package:participa/domain/UseCase/get_history/get_history.dart';
import 'package:participa/domain/entities/history_entity/history_entity.dart';

class HistoryController extends ChangeNotifier {
  final GetHistory getHistory;

  HistoryController(this.getHistory);

  bool loading = false;
  String? error;
  String selectedFilter = 'todos';
  List<HistoryEntity> items = [];

  Future<void> load({String filter = 'todos'}) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      selectedFilter = filter;
      items = await getHistory(type: filter);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void applyFilter(String filter) => load(filter: filter);
}
