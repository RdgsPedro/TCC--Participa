class HistoryEntity {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime date;
  final String action;

  const HistoryEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.date,
    required this.action,
  });
}
