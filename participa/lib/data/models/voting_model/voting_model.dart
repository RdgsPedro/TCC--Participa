import 'package:participa/data/models/description_model/description_voting_model.dart';
import 'package:participa/data/models/option_vote_model/option_vote_model.dart';
import 'package:participa/data/models/voting_result_model/voting_result_model.dart';
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

class VotingModel extends VotingEntity {
  const VotingModel({
    required super.id,
    required super.image,
    required super.title,
    required super.descriptions,
    required super.options,
    required super.status,
    required super.startDate,
    required super.endDate,
    required super.tag,
    super.results,
  });

  factory VotingModel.fromJson(Map<String, dynamic> json) {
    return VotingModel(
      id: json['id'] as int,
      image: json['image'] as String,
      title: json['title'] as String,
      descriptions: (json['descriptions'] as List<dynamic>)
          .map((d) => DescriptionModel.fromJson(d as Map<String, dynamic>))
          .toList(),
      options: (json['options'] as List<dynamic>)
          .map((o) => OptionVoteModel.fromJson(o as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      tag: json['tag'] as String,
      results: json['results'] != null
          ? (json['results'] as List<dynamic>)
                .map(
                  (r) => VotingResultModel.fromJson(r as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'title': title,
    'descriptions': descriptions
        .map((d) => (d as DescriptionModel).toJson())
        .toList(),
    'options': options.map((o) => (o as OptionVoteModel).toJson()).toList(),
    'status': status,
    'startDate': startDate,
    'endDate': endDate,
    'tag': tag,
    'results': results?.map((r) => (r as VotingResultModel).toJson()).toList(),
  };
}
