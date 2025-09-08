import 'package:participa/data/datasources/notification_datasource/notification_remote_data_source.dart';
import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';
import 'package:participa/domain/repositories/notification_repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDataSource dataSource;

  NotificationRepositoryImpl(this.dataSource);

  @override
  Future<List<NotificationEntity>> getNotifications() async {
    final result = await dataSource.getNotifications();
    return result;
  }
}
