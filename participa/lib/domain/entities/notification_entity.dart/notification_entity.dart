class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final String type;
  final DateTime timestamp;
  final String? imageUrl;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    this.imageUrl,
  });
}
