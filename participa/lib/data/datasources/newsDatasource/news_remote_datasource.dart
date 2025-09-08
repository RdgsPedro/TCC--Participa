import 'package:participa/data/models/newsModel/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> fetchNews();
}

class FakeNewsRemoteDataSource implements NewsRemoteDataSource {
  @override
  Future<List<NewsModel>> fetchNews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      NewsModel(
        image:
            "https://ecrie.com.br/sistema/conteudos/imagem/m_55_0_1_20082025142152.jpg",
        title: "Espetáculo infantil será apresentado em Mongaguá",
        tag: "Cultura",
        source: "Prefeitura de Mongaguá",
        time: "2 horas atrás",
        description:
            "Mongaguá, conhecida por sua vocação turística e cultural, receberá um espetáculo infantil especial neste fim de semana. O evento promete encantar crianças e adultos com música, dança e encenações interativas, levando ao palco personagens lúdicos e mensagens educativas sobre amizade e preservação ambiental. A apresentação integra o calendário cultural da cidade e será realizada em espaço público com entrada gratuita, oferecendo lazer acessível para toda a família.",
        link:
            'https://mongagua.sp.gov.br/noticias/cultura/gratuito-espetaculo-infantil-quanta-coisa-o-lixo-e-sera-apresentado-em-mongagua-neste-fim-de-semana',
      ),

      NewsModel(
        image: "https://picsum.photos/800/500?school",
        title: "ETEC Adolpho Berezin abre inscrições para cursos técnicos",
        tag: "Educação",
        source: "ETEC Mongaguá",
        time: "Ontem",
        description:
            "A ETEC Adolpho Berezin anunciou a abertura de inscrições para diversos cursos técnicos em áreas como tecnologia, saúde, turismo e gestão. As vagas são voltadas a jovens e adultos que buscam qualificação profissional de qualidade e gratuita, fortalecendo a formação técnica na região. As aulas serão presenciais, com professores especializados e infraestrutura moderna, preparando os estudantes para o mercado de trabalho e para o ingresso em carreiras acadêmicas futuras.",
        link: '213123',
      ),
      NewsModel(
        image: "https://picsum.photos/800/500?school",
        title: "Atração turística: Plataforma de Pesca de Mongaguá",
        tag: "Turismo",
        source: "Secretaria de Turismo",
        time: "Há pouco",
        description:
            "A famosa Plataforma de Pesca de Mongaguá, com seus 400 metros de extensão sobre o mar, é uma das atrações turísticas mais visitadas do litoral sul paulista. Além de ser ponto de encontro para pescadores amadores e profissionais, o local oferece uma vista deslumbrante do oceano e do pôr do sol. Sua estrutura conta com espaço para visitantes, guarda-corpo seguro e fácil acesso para famílias. É um verdadeiro cartão-postal que une lazer, esporte e contemplação da natureza.",
        link: '213123',
      ),
      NewsModel(
        image: "https://picsum.photos/800/500?school",
        title: "Natureza e cultura: Poço das Antas em Mongaguá",
        tag: "Ecoturismo",
        source: "Fundação Municipal de Turismo",
        time: "Hoje",
        description:
            "O Poço das Antas é uma das joias naturais de Mongaguá, reunindo cachoeira, piscina natural e trilhas em meio à Mata Atlântica preservada. Localizado em área de fácil acesso, o espaço é ideal para famílias, grupos de amigos e aventureiros que buscam contato direto com a natureza. Além do banho refrescante em águas cristalinas, o Poço também é palco de manifestações culturais e atividades de educação ambiental, tornando-se referência em ecoturismo sustentável na região.",

        link: '213123',
      ),
      NewsModel(
        image: "https://picsum.photos/800/500?school",
        title: "Mirante da Padroeira oferece vista panorâmica",
        tag: "Turismo",
        source: "Visite Mongaguá",
        time: "Há instantes",
        description:
            "Localizado no topo do Morro da Padroeira, o Mirante da Padroeira proporciona uma vista panorâmica única de Mongaguá e do oceano Atlântico. No local também está instalada a imagem de Nossa Senhora Aparecida, que recebe visitantes e devotos durante todo o ano. Além de ser ponto turístico e religioso, o espaço é utilizado para eventos e celebrações, tornando-se um dos símbolos da cidade. Do alto, é possível contemplar o litoral em toda sua extensão, especialmente ao nascer e ao pôr do sol.",

        link: '213123',
      ),
    ];
  }
}
