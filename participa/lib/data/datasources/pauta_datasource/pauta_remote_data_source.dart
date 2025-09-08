import 'dart:async';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/domain/entities/description_entity/description_entity.dart';

abstract class PautaRemoteDataSource {
  Future<List<PautaEntity>> fetchPautas();
  Future<PautaEntity> createPauta(PautaEntity pauta);
  Future<PautaEntity> updatePauta(PautaEntity pauta);
  Future<void> deletePauta(int pautaId);
  Future<void> reportPauta(int pautaId, String motivo);

  Future<CommentEntity> addComment(int pautaId, CommentEntity comment);
  Future<void> reportComment(int pautaId, int commentId, String motivo);
}

class PautaRemoteDataSourceImpl implements PautaRemoteDataSource {
  final List<PautaEntity> _mockDb = [
    PautaEntity(
      id: 1,
      title: "Revitalização da Praça Central",
      image:
          "https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=800&q=80",
      userId: "u1",
      userName: "Maria Oliveira",
      userPhotoUrl: "https://randomuser.me/api/portraits/women/44.jpg",
      createdAt: DateTime(2025, 8, 20, 14, 30),
      descriptions: const [
        DescriptionEntity(
          title: "Objetivo",
          info:
              "Renovar os brinquedos do parquinho e adicionar academia ao ar livre.",
        ),
        DescriptionEntity(
          title: "Investimento",
          info: "R\$ 850 mil em recursos municipais.",
        ),
      ],
      comments: [
        CommentEntity(
          id: 1,
          userId: "u2",
          userName: "João Silva",
          userPhotoUrl: "https://randomuser.me/api/portraits/men/32.jpg",
          text: "Ótima iniciativa! As crianças precisam de espaços melhores.",
          createdAt: DateTime(2025, 8, 21, 10, 15),
        ),
      ],
    ),
    PautaEntity(
      id: 2,
      title: "Criação de Ciclovia na Av. Beira-Mar",
      image:
          "https://images.unsplash.com/photo-1503264116251-35a269479413?auto=format&fit=crop&w=800&q=80",
      userId: "u3",
      userName: "Carlos Souza",
      userPhotoUrl: "https://randomuser.me/api/portraits/men/41.jpg",
      createdAt: DateTime(2025, 8, 25, 9, 45),
      descriptions: const [
        DescriptionEntity(
          title: "Proposta",
          info:
              "Construção de ciclovia ao longo da avenida para incentivar mobilidade sustentável.",
        ),
        DescriptionEntity(
          title: "Benefícios",
          info: "Melhora no trânsito e incentivo ao uso de bicicletas.",
        ),
      ],
      comments: [
        CommentEntity(
          id: 2,
          userId: "u4",
          userName: "Ana Clara",
          userPhotoUrl: "https://randomuser.me/api/portraits/women/68.jpg",
          text: "Vai ser excelente para quem pedala diariamente!",
          createdAt: DateTime(2025, 8, 26, 17, 20),
        ),
      ],
    ),
  ];

  @override
  Future<List<PautaEntity>> fetchPautas() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDb;
  }

  @override
  Future<PautaEntity> createPauta(PautaEntity pauta) async {
    _mockDb.add(pauta);
    return pauta;
  }

  @override
  Future<PautaEntity> updatePauta(PautaEntity pauta) async {
    final index = _mockDb.indexWhere((p) => p.id == pauta.id);
    if (index != -1) {
      _mockDb[index] = pauta;
    }
    return pauta;
  }

  @override
  Future<void> deletePauta(int pautaId) async {
    _mockDb.removeWhere((p) => p.id == pautaId);
  }

  @override
  Future<void> reportPauta(int pautaId, String motivo) async {
    print("Pauta $pautaId denunciada. Motivo: $motivo");
  }

  @override
  Future<CommentEntity> addComment(int pautaId, CommentEntity comment) async {
    final pauta = _mockDb.firstWhere((p) => p.id == pautaId);
    final updated = PautaEntity(
      id: pauta.id,
      title: pauta.title,
      image: pauta.image,
      userId: pauta.userId,
      userName: pauta.userName,
      userPhotoUrl: pauta.userPhotoUrl,
      createdAt: pauta.createdAt,
      descriptions: pauta.descriptions,
      comments: [...pauta.comments, comment],
    );
    await updatePauta(updated);
    return comment;
  }

  @override
  Future<void> reportComment(int pautaId, int commentId, String motivo) async {
    print(
      "Comentário $commentId da pauta $pautaId denunciado. Motivo: $motivo",
    );
  }
}
