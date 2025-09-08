import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';

abstract class NotificationRepository {
  Future<List<NotificationEntity>> getNotifications();
}
