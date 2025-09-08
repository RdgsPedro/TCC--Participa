import 'dart:async';
import 'package:participa/data/models/description_model/description_voting_model.dart';
import 'package:participa/data/models/option_vote_model/option_vote_model.dart';
import 'package:participa/data/models/voting_model/voting_model.dart';
import 'package:participa/data/models/voting_result_model/voting_result_model.dart';
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

abstract class VotingRemoteDataSource {
  Future<List<VotingEntity>> fetchVoting();
  Future<void> sendVote(int votingId, int optionId);
}

class VotingRemoteDataSourceImpl implements VotingRemoteDataSource {
  @override
  Future<List<VotingEntity>> fetchVoting() async {
    await Future.delayed(const Duration(milliseconds: 600));

    final mock = [
      VotingModel(
        id: 1,
        image:
            "https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Revitalização da Orla de Mongaguá",
        descriptions: const [
          DescriptionModel(
            title: "Projeto",
            info:
                "Reforma completa da orla marítima com novo calçadão, ciclovia e quiosques. Reforma completa da orla marítima com novo calçadão, ciclovia e quiosques.",
          ),
          DescriptionModel(
            title: "Benefícios",
            info: "Melhoria do turismo e lazer para moradores e visitantes",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Concordo"),
          OptionVoteModel(id: 2, text: "Discordo"),
          OptionVoteModel(id: 3, text: "Precisa de ajustes"),
          OptionVoteModel(id: 4, text: "Não apoio"),
        ],
        status: "Aberta",
        startDate: "2025-08-01",
        endDate: "2025-08-15",
        tag: "Turismo",
      ),
      VotingModel(
        id: 2,
        image:
            "https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Melhoria do Parque Ecológico Açaí",
        descriptions: const [
          DescriptionModel(
            title: "Proposta",
            info:
                "Ampliação das trilhas ecológicas e reforma da infraestrutura do parque",
          ),
          DescriptionModel(
            title: "Investimento",
            info: "RS 1.2 milhões em recursos municipais",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Apoio total"),
          OptionVoteModel(id: 2, text: "Apoio com ressalvas"),
          OptionVoteModel(id: 3, text: "Não apoio"),
        ],
        status: "Aberta",
        startDate: "2025-09-01",
        endDate: "2025-09-30",
        tag: "Meio Ambiente",
      ),
      VotingModel(
        id: 3,
        image:
            "https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Nova Linha de Ônibus Mongaguá-Praia Grande",
        descriptions: const [
          DescriptionModel(
            title: "Proposta",
            info:
                "Criação de linha direta conectando Mongaguá ao centro de Praia Grande",
          ),
          DescriptionModel(
            title: "Frequência",
            info: "Ônibus a cada 30 minutos das 6h às 22h",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Muito necessário"),
          OptionVoteModel(id: 2, text: "Necessário"),
          OptionVoteModel(id: 3, text: "Dispensável"),
        ],
        status: "Encerrada",
        startDate: "2025-06-01",
        endDate: "2025-06-30",
        tag: "Mobilidade",
        results: const [
          VotingResultModel(optionId: 1, votes: 120),
          VotingResultModel(optionId: 2, votes: 80),
          VotingResultModel(optionId: 3, votes: 25),
        ],
      ),
      VotingModel(
        id: 4,
        image:
            "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Reforma da Escola Municipal Prof. João Octaviano",
        descriptions: const [
          DescriptionModel(
            title: "Escopo",
            info:
                "Reforma das salas de aula, quadra esportiva e laboratório de informática",
          ),
          DescriptionModel(
            title: "Recursos",
            info: "Verba federal do FNDE - RS 850 mil",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Prioridade"),
          OptionVoteModel(id: 2, text: "Importante"),
          OptionVoteModel(id: 3, text: "Pode aguardar"),
        ],
        status: "Aberta",
        startDate: "2025-08-20",
        endDate: "2025-09-20",
        tag: "Educação",
      ),
      VotingModel(
        id: 5,
        image:
            "https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Implantação da Coleta Seletiva em Mongaguá",
        descriptions: const [
          DescriptionModel(
            title: "Objetivo",
            info:
                "Coleta seletiva porta a porta em todos os bairros do município",
          ),
          DescriptionModel(
            title: "Metas",
            info: "50% de reciclagem do lixo municipal até 2026",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Essencial"),
          OptionVoteModel(id: 2, text: "Importante"),
          OptionVoteModel(id: 3, text: "Não prioritário"),
        ],
        status: "Encerrada",
        startDate: "2025-05-01",
        endDate: "2025-05-31",
        tag: "Sustentabilidade",
      ),
      VotingModel(
        id: 6,
        image:
            "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Urbanização do Jardim São Paulo",
        descriptions: const [
          DescriptionModel(
            title: "Projeto",
            info:
                "Pavimentação, drenagem e iluminação pública no Jardim São Paulo",
          ),
          DescriptionModel(title: "Área", info: "20 ruas e 5 praças do bairro"),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Urgente"),
          OptionVoteModel(id: 2, text: "Necessário"),
          OptionVoteModel(id: 3, text: "Outras prioridades"),
        ],
        status: "Aberta",
        startDate: "2025-10-01",
        endDate: "2025-11-15",
        tag: "Infraestrutura",
      ),
      VotingModel(
        id: 7,
        image:
            "https://images.unsplash.com/photo-1571624436279-b272aff752b5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Criação do Centro Cultural de Mongaguá",
        descriptions: const [
          DescriptionModel(
            title: "Proposta",
            info:
                "Centro cultural com teatro, biblioteca e salas de aula para cursos",
          ),
          DescriptionModel(
            title: "Localização",
            info: "Terreno da antiga escola no centro da cidade",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Excelente ideia"),
          OptionVoteModel(id: 2, text: "Apoio moderado"),
          OptionVoteModel(id: 3, text: "Não é necessário"),
        ],
        status: "Encerrada",
        startDate: "2025-04-01",
        endDate: "2025-04-30",
        tag: "Cultura",
      ),
      VotingModel(
        id: 8,
        image:
            "https://images.unsplash.com/photo-1581094271901-8242d0fcd6a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80",
        title: "Ampliação do Posto de Saúde Central",
        descriptions: const [
          DescriptionModel(
            title: "Expansão",
            info:
                "Ampliação do posto de saúde com novas especialidades e equipamentos",
          ),
          DescriptionModel(
            title: "Especialidades",
            info: "Cardiologia, pediatria, ginecologia e oftalmologia",
          ),
        ],
        options: const [
          OptionVoteModel(id: 1, text: "Muito importante"),
          OptionVoteModel(id: 2, text: "Importante"),
          OptionVoteModel(id: 3, text: "Pode esperar"),
        ],
        status: "Aberta",
        startDate: "2025-09-15",
        endDate: "2025-10-15",
        tag: "Saúde",
      ),
    ];

    return mock;
  }

  @override
  Future<void> sendVote(int votingId, int optionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    print("Voto registrado: votação=$votingId, opção=$optionId");
  }
}
