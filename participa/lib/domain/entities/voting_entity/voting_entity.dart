import 'package:participa/domain/entities/description_entity/description_entity.dart';

class VotingEntity {
  final int id;
  final String image;
  final String title;
  final List<DescriptionEntity> descriptions;
  final List<OptionVoteEntity> options;
  final String status;
  final String startDate;
  final String endDate;
  final String tag;

  final List<VotingResultEntity>? results;

  const VotingEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.descriptions,
    required this.options,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.tag,
    this.results,
  });
}

class OptionVoteEntity {
  final int id;
  final String text;
  const OptionVoteEntity({required this.id, required this.text});
}

class VotingResultEntity {
  final int optionId;
  final int votes;

  const VotingResultEntity({required this.optionId, required this.votes});
}
