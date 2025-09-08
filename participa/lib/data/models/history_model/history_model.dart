import 'package:participa/domain/entities/history_entity/history_entity.dart';

class HistoryModel extends HistoryEntity {
  const HistoryModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.date,
    required super.action,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'].toString(),
      type: json['type'] ?? 'pauta',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      action: json['action'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    'action': action,
  };
}
