import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class DeletePauta {
  final PautaRepository repository;
  DeletePauta(this.repository);

  Future<void> call(int pautaId) async {
    return await repository.deletePauta(pautaId);
  }
}
