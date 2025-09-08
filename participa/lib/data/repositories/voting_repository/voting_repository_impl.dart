import 'package:participa/data/datasources/voting_datasource/voting_remote_data_source.dart';
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';
import 'package:participa/domain/repositories/voting_repository/voting_repository.dart';

class VotingRepositoryImpl implements VotingRepository {
  final VotingRemoteDataSource remoteDataSource;
  VotingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<VotingEntity>> getVoting() async {
    return await remoteDataSource.fetchVoting();
  }

  @override
  Future<void> sendVote(int idVotacao, int idOpcao) async {
    return await remoteDataSource.sendVote(idVotacao, idOpcao);
  }
}
