import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class ReportComment {
  final PautaRepository repository;
  ReportComment(this.repository);

  Future<void> call(int pautaId, int commentId, String motivo) async {
    return await repository.reportComment(pautaId, commentId, motivo);
  }
}
