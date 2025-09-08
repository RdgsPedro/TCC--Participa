import 'dart:async';
import 'package:participa/data/models/history_model/history_model.dart';

abstract class HistoryDataSource {
  Future<List<HistoryModel>> getHistory();
}

class HistoryRemoteDataSource implements HistoryDataSource {
  @override
  Future<List<HistoryModel>> getHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      HistoryModel(
        id: "1",
        type: "votacao",
        title: "Construção de Novo Hospital Municipal",
        description: "Votação sobre construção do hospital municipal.",
        date: DateTime(2025, 10, 16),
        action: "Você votou: Concordo",
      ),
      HistoryModel(
        id: "2",
        type: "comentario",
        title: "Uso da praça Dudu Samba para fins culturais nos fins de semana",
        description: "Comentário realizado em pauta pública.",
        date: DateTime(2025, 01, 19),
        action: "Você comentou",
      ),
      HistoryModel(
        id: "3",
        type: "pauta",
        title: "Uso da praça Dudu Samba para fins culturais nos fins de semana",
        description: "Pauta criada para avaliação da Secretaria.",
        date: DateTime(2025, 01, 19),
        action: "Você criou uma pauta",
      ),
      HistoryModel(
        id: "4",
        type: "denuncia",
        title: "Aulas de educação ambiental na rede pública",
        description: "Denúncia referente à falta de aulas no Parque Ecológico.",
        date: DateTime(2025, 01, 19),
        action: "Você denunciou",
      ),
    ];
  }
}
