import 'package:flutter/material.dart';
import 'package:participa/presentation/controllers/newsController/news_controller.dart';
import 'package:provider/provider.dart';
import 'package:participa/data/repositories/newsRepository/news_repository_impl.dart';
import 'package:participa/domain/UseCase/getNews/get_news.dart';
import 'package:participa/presentation/widgets/filter/filter.dart';
import 'package:participa/presentation/widgets/news_carousel/news_carousel.dart';
import 'package:participa/presentation/widgets/news_options/news_options.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewsController(GetNews(NewsRepositoryImpl()))..load(),
      child: const _NewsPageContent(),
    );
  }
}

class _NewsPageContent extends StatefulWidget {
  const _NewsPageContent();

  @override
  State<_NewsPageContent> createState() => _NewsPageContentState();
}

class _NewsPageContentState extends State<_NewsPageContent> {
  String _selectedCategory = "Todas";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(
          "Notícias",
          style: TextStyle(
            color: theme.colorScheme.tertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
        scrolledUnderElevation: 0,
      ),
      body: Consumer<NewsController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error != null) {
            return Center(child: Text("Erro: ${controller.error}"));
          }
          if (controller.items.isEmpty) {
            return const Center(child: Text("Nenhuma notícia encontrada"));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                NewsSlider(),
                const SizedBox(height: 10),
                FilterTabs(
                  options: ["Todas", "Educação", "Cultura", "Segurança"],
                  onChanged: (selected) {
                    setState(() {
                      _selectedCategory = selected;
                    });
                  },
                ),
                const SizedBox(height: 10),
                NewsOptions(category: _selectedCategory),
              ],
            ),
          );
        },
      ),
    );
  }
}
