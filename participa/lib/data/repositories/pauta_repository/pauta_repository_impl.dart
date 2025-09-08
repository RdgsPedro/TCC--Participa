import 'package:participa/data/datasources/pauta_datasource/pauta_remote_data_source.dart';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class PautaRepositoryImpl implements PautaRepository {
  final PautaRemoteDataSource remoteDataSource;

  PautaRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PautaEntity>> getPautas() async {
    return await remoteDataSource.fetchPautas();
  }

  @override
  Future<PautaEntity> createPauta(PautaEntity pauta) async {
    return await remoteDataSource.createPauta(pauta);
  }

  @override
  Future<PautaEntity> updatePauta(PautaEntity pauta) async {
    return await remoteDataSource.updatePauta(pauta);
  }

  @override
  Future<void> deletePauta(int pautaId) async {
    return await remoteDataSource.deletePauta(pautaId);
  }

  @override
  Future<void> reportPauta(int pautaId, String motivo) async {
    return await remoteDataSource.reportPauta(pautaId, motivo);
  }

  @override
  Future<CommentEntity> addComment(int pautaId, CommentEntity comment) async {
    return await remoteDataSource.addComment(pautaId, comment);
  }

  @override
  Future<void> reportComment(int pautaId, int commentId, String motivo) async {
    return await remoteDataSource.reportComment(pautaId, commentId, motivo);
  }
}
