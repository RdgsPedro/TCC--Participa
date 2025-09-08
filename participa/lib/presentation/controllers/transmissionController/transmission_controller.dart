import 'package:flutter/material.dart';
import 'package:participa/domain/UseCase/getTransmission/get_transmission.dart';
import 'package:participa/domain/entities/transmissionEntity/transmission_entity.dart';

class TransmissionController extends ChangeNotifier {
  final GetTransmission _getTransmission;
  TransmissionController(this._getTransmission);

  final List<TransmissionEntity> items = [];
  bool loading = false;
  String? error;
  int currentIndex = 0;

  bool _disposed = false;

  Future<void> load() async {
    loading = true;
    error = null;
    if (!_disposed) notifyListeners();

    try {
      final fetched = await _getTransmission();
      if (_disposed) return;
      items
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      if (_disposed) return;
      error = e.toString();
    } finally {
      if (_disposed) return;
      loading = false;
      notifyListeners();
    }
  }

  void setIndex(int i) {
    currentIndex = i;
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
