import 'package:participa/data/models/transmissionModel/transmission_model.dart';

abstract class TransmissionRemoteDataSource {
  Future<List<TransmissionModel>> fetchTransmission();
}

class FakeTransmissionRemoteDataSource implements TransmissionRemoteDataSource {
  @override
  Future<List<TransmissionModel>> fetchTransmission() async {
    await Future.delayed(const Duration(milliseconds: 400)); // simula rede
    return [
      TransmissionModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        photo:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Sessão Ordinária da Câmara Municipal de Mongaguá",
        subtitle: "Educação em foco",
        source: "Câmara de Mongaguá",
        time: "23/04/2024 - 19h",
        description:
            "Debate sobre investimentos em escolas municipais e melhorias no transporte escolar.",
        link: "https://camaramongagua.sp.gov.br/sessao/23042024",
      ),

      TransmissionModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        photo:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Audiência Pública sobre Meio Ambiente",
        subtitle: "Sustentabilidade e Coleta Seletiva",
        source: "Prefeitura de Mongaguá",
        time: "28/04/2024 - 14h",
        description:
            "Discussão sobre a ampliação da coleta seletiva e preservação de áreas verdes.",
        link: "https://prefeiturademongagua.sp.gov.br/audiencia/28042024",
      ),

      TransmissionModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        photo:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Sessão Extraordinária: Plano Diretor",
        subtitle: "Planejamento Urbano",
        source: "Câmara Municipal",
        time: "05/05/2024 - 18h",
        description:
            "Votação de propostas de revisão do Plano Diretor de Desenvolvimento Urbano.",
        link: "https://camaramongagua.sp.gov.br/sessao/05052024",
      ),

      TransmissionModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        photo:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Entrevista Coletiva com o Prefeito",
        subtitle: "Projetos de Infraestrutura",
        source: "Prefeitura",
        time: "12/05/2024 - 10h",
        description:
            "Prefeito apresenta novos projetos de pavimentação e melhorias no transporte público.",
        link: "https://prefeiturademongagua.sp.gov.br/coletiva/12052024",
      ),

      TransmissionModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        photo:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Reunião sobre Saúde Pública",
        subtitle: "Campanhas de Vacinação",
        source: "Secretaria de Saúde",
        time: "20/05/2024 - 15h",
        description:
            "Discussão sobre campanhas de vacinação e ampliação de postos de atendimento.",
        link: "https://saude.mongagua.sp.gov.br/transmissao/20052024",
      ),
    ];
  }
}
