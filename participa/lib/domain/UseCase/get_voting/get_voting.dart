// get_voting.dart
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';
import 'package:participa/domain/repositories/voting_repository/voting_repository.dart';

class GetVoting {
  final VotingRepository repository;
  GetVoting(this.repository);

  Future<List<VotingEntity>> call() async {
    return await repository.getVoting();
  }
}
