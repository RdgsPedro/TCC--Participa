import 'package:participa/domain/entities/description_entity/description_entity.dart';

class DescriptionModel extends DescriptionEntity {
  const DescriptionModel({required super.title, required super.info});

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    return DescriptionModel(
      title: json['title'] as String,
      info: json['info'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'info': info};
}
