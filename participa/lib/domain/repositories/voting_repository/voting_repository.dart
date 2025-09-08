import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

abstract class VotingRepository {
  Future<List<VotingEntity>> getVoting();
  Future<void> sendVote(int idVotacao, int idOpcao);
}
