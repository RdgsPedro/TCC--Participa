import 'package:participa/data/datasources/transmissionDatasourse/transmission_remote_datasourse.dart';
import 'package:participa/domain/entities/transmissionEntity/transmission_entity.dart';
import 'package:participa/domain/repositories/transmissionRepository/transmission_repository.dart';

class TransmissionRepositoryImpl implements TransmissionRepository {
  final TransmissionRemoteDataSource remoteDataSource;

  TransmissionRepositoryImpl([TransmissionRemoteDataSource? dataSource])
    : remoteDataSource = dataSource ?? FakeTransmissionRemoteDataSource();

  @override
  Future<List<TransmissionEntity>> getTransmission() {
    return remoteDataSource.fetchTransmission();
  }
}
