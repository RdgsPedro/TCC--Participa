import 'package:flutter/material.dart';
import 'package:participa/domain/UseCase/get_notifications/get_notifications.dart';
import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';

class NotificationController extends ChangeNotifier {
  final GetNotifications getNotificationsUseCase;

  NotificationController(this.getNotificationsUseCase);

  List<NotificationEntity> _notifications = [];
  List<NotificationEntity> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _disposed = false;

  String _mapCategoryToType(String category) {
    final c = category.trim().toLowerCase();

    const map = {
      'todas': 'todas',
      'votações': 'voting',
      'votacoes': 'voting',
      'notícias': 'news',
      'noticias': 'news',
      'transmissões': 'transmission',
      'transmissoes': 'transmission',
    };

    return map[c] ?? c;
  }

  Future<void> fetchNotifications({String category = "Todas"}) async {
    _isLoading = true;
    _errorMessage = null;
    if (!_disposed) notifyListeners();

    try {
      final result = await getNotificationsUseCase();
      if (_disposed) return;

      final mapped = _mapCategoryToType(category);

      if (mapped == "todas") {
        _notifications = result;
      } else {
        _notifications = result
            .where((n) => n.type.toLowerCase() == mapped.toLowerCase())
            .toList();
      }
    } catch (e) {
      if (_disposed) return;
      _errorMessage = e.toString();
    }

    _isLoading = false;
    if (!_disposed) notifyListeners();
  }
}
