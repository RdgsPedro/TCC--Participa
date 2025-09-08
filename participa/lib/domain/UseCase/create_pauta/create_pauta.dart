import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class CreatePauta {
  final PautaRepository repository;
  CreatePauta(this.repository);

  Future<PautaEntity> call(PautaEntity pauta) async {
    return await repository.createPauta(pauta);
  }
}
