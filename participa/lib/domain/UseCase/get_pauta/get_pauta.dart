import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/repositories/pauta_repository/pauta_repository.dart';

class GetPautas {
  final PautaRepository repository;
  GetPautas(this.repository);

  Future<List<PautaEntity>> call() async {
    return await repository.getPautas();
  }
}
