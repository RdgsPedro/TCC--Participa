import 'package:participa/domain/entities/transmissionEntity/transmission_entity.dart';

class TransmissionModel extends TransmissionEntity {
  const TransmissionModel({
    required super.image,
    required super.photo,
    required super.title,
    required super.subtitle,
    required super.source,
    required super.time,
    required super.description,
    required super.link,
  });

  factory TransmissionModel.fromJson(Map<String, dynamic> json) =>
      TransmissionModel(
        image: json['image'] as String,
        photo: json['photo'] as String,
        title: json['title'] as String,
        subtitle: json['subtitle'] as String,
        source: json['source'] as String,
        time: json['time'] as String,
        description: json['description'] as String,
        link: json['link'] as String,
      );

  Map<String, dynamic> toJson() => {
    'image': image,
    'photo': photo,
    'title': title,
    'subtitle': subtitle,
    'source': source,
    'time': time,
    'description': time,
    'link': link,
  };
}
