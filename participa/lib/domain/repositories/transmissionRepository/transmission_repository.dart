import 'package:participa/domain/entities/transmissionEntity/transmission_entity.dart';

abstract class TransmissionRepository {
  Future<List<TransmissionEntity>> getTransmission();
}
