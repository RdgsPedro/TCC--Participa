import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  NotificationModel({
    required String id,
    required String title,
    required String message,
    required String type,
    required DateTime timestamp,
    String? imageUrl,
  }) : super(
         id: id,
         title: title,
         message: message,
         type: type,
         timestamp: timestamp,
         imageUrl: imageUrl,
       );

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'news',
      timestamp: DateTime.parse(json['timestamp'] as String),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}
