import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class ReportPauta {
  final PautaRepository repository;
  ReportPauta(this.repository);

  Future<void> call(int pautaId, String motivo) async {
    return await repository.reportPauta(pautaId, motivo);
  }
}
