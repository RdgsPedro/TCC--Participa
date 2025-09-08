import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';

abstract class PautaRepository {
  Future<List<PautaEntity>> getPautas();
  Future<PautaEntity> createPauta(PautaEntity pauta);
  Future<PautaEntity> updatePauta(PautaEntity pauta);
  Future<void> deletePauta(int pautaId);

  Future<void> reportPauta(int pautaId, String motivo);

  Future<CommentEntity> addComment(int pautaId, CommentEntity comment);
  Future<void> reportComment(int pautaId, int commentId, String motivo);
}
