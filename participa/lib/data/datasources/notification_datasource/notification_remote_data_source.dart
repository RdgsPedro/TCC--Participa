import 'dart:async';
import 'package:participa/data/models/notification_model/notification_model.dart';

abstract class NotificationDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSource implements NotificationDataSource {
  @override
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 700));
    final now = DateTime.now();

    return [
      NotificationModel(
        id: '1',
        title: 'Nova notícia sobre coleta seletiva',
        message: 'Projeto de reciclagem apresentado pela prefeitura.',
        type: 'news',
        timestamp: now.subtract(const Duration(hours: 2, minutes: 40)),
        imageUrl: 'https://i.pravatar.cc/150?img=5',
      ),

      NotificationModel(
        id: '2',
        title: 'Alguém respondeu seu comentário na pauta',
        message:
            'João respondeu: "Concordo, precisamos priorizar isso." — Pauta: Obras no bairro X.',
        type: 'news',
        timestamp: now.subtract(const Duration(hours: 1, minutes: 10)),
        imageUrl: 'https://i.pravatar.cc/150?img=21',
      ),

      NotificationModel(
        id: '3',
        title: 'Transmissão ao vivo: Sessão da Câmara',
        message: 'Acompanhe a sessão que debate melhorias no bairro X.',
        type: 'transmission',
        timestamp: now.subtract(const Duration(hours: 3, minutes: 10)),
        imageUrl: null,
      ),

      NotificationModel(
        id: '4',
        title: 'Alguém respondeu seu comentário na pauta',
        message:
            'Mariana respondeu: "Boa sugestão — vou encaminhar ao setor responsável." — Pauta: Coleta seletiva.',
        type: 'news',
        timestamp: now.subtract(const Duration(days: 1, hours: 2)),
        imageUrl: 'https://i.pravatar.cc/150?img=30',
      ),

      NotificationModel(
        id: '5',
        title: 'Comentário em sua publicação',
        message:
            'Dawson comentou: "Ótima iniciativa!" — referente à pauta sobre educação.',
        type: 'news',
        timestamp: now.subtract(const Duration(days: 3)),
        imageUrl: 'https://i.pravatar.cc/150?img=44',
      ),

      NotificationModel(
        id: '6',
        title: 'Votação pública aberta',
        message:
            'Participe da votação sobre prioridade de obras — sua participação conta.',
        type: 'voting',
        timestamp: now.subtract(const Duration(days: 5)),
        imageUrl: null,
      ),
    ];
  }
}
