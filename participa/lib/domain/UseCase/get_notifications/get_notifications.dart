import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';
import 'package:participa/domain/repositories/notification_repository/notification_repository.dart';

class GetNotifications {
  final NotificationRepository repository;

  GetNotifications(this.repository);

  Future<List<NotificationEntity>> call() async {
    return await repository.getNotifications();
  }
}
