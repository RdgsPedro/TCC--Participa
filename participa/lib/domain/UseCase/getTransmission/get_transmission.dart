import 'package:participa/domain/entities/transmissionEntity/transmission_entity.dart';
import 'package:participa/domain/repositories/transmissionRepository/transmission_repository.dart';

class GetTransmission {
  final TransmissionRepository repository;
  GetTransmission(this.repository);

  Future<List<TransmissionEntity>> call() async {
    return await repository.getTransmission();
  }
}
