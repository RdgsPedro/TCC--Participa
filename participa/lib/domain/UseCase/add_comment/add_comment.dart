import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class AddComment {
  final PautaRepository repository;
  AddComment(this.repository);

  Future<CommentEntity> call(int pautaId, CommentEntity comment) async {
    return await repository.addComment(pautaId, comment);
  }
}
