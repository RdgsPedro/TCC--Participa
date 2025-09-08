import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

class VotingResultModel extends VotingResultEntity {
  const VotingResultModel({required super.optionId, required super.votes});

  factory VotingResultModel.fromJson(Map<String, dynamic> json) {
    return VotingResultModel(
      optionId: json['optionId'] as int,
      votes: json['votes'] as int,
    );
  }

  Map<String, dynamic> toJson() => {'optionId': optionId, 'votes': votes};
}
