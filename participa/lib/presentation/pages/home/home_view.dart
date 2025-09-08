import 'package:flutter/material.dart';
import 'package:participa/data/repositories/newsRepository/news_repository_impl.dart';
import 'package:participa/domain/UseCase/getNews/get_news.dart';
import 'package:participa/presentation/controllers/newsController/news_controller.dart';
import 'package:participa/presentation/pages/configuration/configuration_page.dart';
import 'package:participa/presentation/pages/notification/notification_page.dart';
import 'package:participa/presentation/widgets/news_carousel/news_carousel.dart';
import 'package:participa/presentation/widgets/service_card/service_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final Function(int) onNavigate;

  const HomeView({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/PARTICIPA.png',
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            Text(
              "Participa",
              style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConfigurationPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChangeNotifierProvider(
              create: (_) =>
                  NewsController(GetNews(NewsRepositoryImpl()))..load(),
              child: const NewsSlider(),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Serviços Disponíveis",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2.2,
                children: [
                  CardsButtons(
                    icon: Icons.how_to_vote,
                    label: 'Votações',
                    onTap: () => onNavigate(2),
                  ),
                  CardsButtons(
                    icon: Icons.waving_hand,
                    label: 'Pautas',
                    onTap: () => onNavigate(4),
                  ),
                  CardsButtons(
                    icon: Icons.sensors,
                    label: 'Transmissões',
                    onTap: () => onNavigate(3),
                  ),
                  CardsButtons(
                    icon: Icons.newspaper,
                    label: 'Notícias',
                    onTap: () => onNavigate(1),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
