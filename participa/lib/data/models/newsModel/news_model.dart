import 'package:participa/domain/entities/newsEntity/news_entity.dart';

class NewsModel extends NewsEntity {
  const NewsModel({
    required super.image,
    required super.title,
    required super.tag,
    required super.source,
    required super.time,
    required super.description,
    required super.link,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    image: json['image'] as String,
    title: json['title'] as String,
    tag: json['tag'] as String,
    source: json['source'] as String,
    time: json['time'] as String,
    description: json['description'] as String,
    link: json['link'] as String,
  );

  Map<String, dynamic> toJson() => {
    'image': image,
    'title': title,
    'tag': tag,
    'source': source,
    'time': time,
    'description': time,
    'link': link,
  };
}
