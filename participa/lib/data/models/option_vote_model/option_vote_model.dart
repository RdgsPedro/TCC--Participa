import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

class OptionVoteModel extends OptionVoteEntity {
  const OptionVoteModel({required super.id, required super.text});

  factory OptionVoteModel.fromJson(Map<String, dynamic> json) {
    return OptionVoteModel(id: json['id'] as int, text: json['text'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'text': text};
}
