import 'package:participa/domain/repositories/voting_repository/voting_repository.dart';

class SendVote {
  final VotingRepository repository;
  SendVote(this.repository);

  Future<void> call(int idVotacao, int idOpcao) async {
    return await repository.sendVote(idVotacao, idOpcao);
  }
}
