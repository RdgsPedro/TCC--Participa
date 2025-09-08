import 'package:flutter/material.dart';
import 'package:participa/domain/entities/history_entity/history_entity.dart';
import 'package:participa/presentation/controllers/history_controller/history_controller.dart';
import 'package:participa/presentation/widgets/filter/filter.dart';
import 'package:participa/presentation/widgets/history_card/history_card.dart';
import 'package:provider/provider.dart';

import 'package:participa/data/datasources/history_datasource/history_remote_data_source.dart';
import 'package:participa/data/repositories/history_repository/history_repository_impl.dart';
import 'package:participa/domain/UseCase/get_history/get_history.dart';

class ParticipationHistoryPage extends StatefulWidget {
  const ParticipationHistoryPage({super.key});

  @override
  State<ParticipationHistoryPage> createState() =>
      _ParticipationHistoryPageState();
}

class _ParticipationHistoryPageState extends State<ParticipationHistoryPage> {
  String _selectedCategory = "Todas";

  Map<String, List<String>> _getCategoryTypeMapping() {
    return {
      "Todas": [],
      "Votações": ["votacao", "votação"],
      "Comentário": ["comentario", "comentário"],
      "Pauta": ["pauta"],
      "Denúncia": ["denuncia", "denúncia"],
    };
  }

  List<HistoryEntity> _filterItems(
    List<HistoryEntity> allItems,
    String category,
  ) {
    if (category == "Todas") {
      return allItems;
    }

    final mapping = _getCategoryTypeMapping();
    final allowedTypes = mapping[category] ?? [];

    return allItems.where((item) {
      final itemType = (item.type ?? '').toLowerCase();
      return allowedTypes.any((allowedType) => itemType == allowedType);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ChangeNotifierProvider(
      create: (_) => HistoryController(
        GetHistory(HistoryRepositoryImpl(HistoryRemoteDataSource())),
      )..load(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Histórico de Participação",
            style: TextStyle(
              color: colorScheme.tertiary,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Consumer<HistoryController>(
          builder: (context, ctrl, _) {
            final filteredItems = _filterItems(ctrl.items, _selectedCategory);

            return Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterTabs(
                        options: [
                          "Todas",
                          "Votações",
                          "Comentário",
                          "Pauta",
                          "Denúncia",
                        ],
                        onChanged: (selected) {
                          setState(() {
                            _selectedCategory = selected;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: ctrl.loading
                      ? const Center(child: CircularProgressIndicator())
                      : ctrl.error != null
                      ? Center(child: Text('Erro: ${ctrl.error}'))
                      : RefreshIndicator(
                          onRefresh: () async {
                            await ctrl.load();
                          },
                          child: Container(
                            color: colorScheme.surface.withOpacity(0.7),
                            child: filteredItems.isEmpty
                                ? Center(
                                    child: Text(
                                      _selectedCategory == "Todas"
                                          ? "Nenhum histórico encontrado"
                                          : "Nenhum item na categoria $_selectedCategory",
                                      style: TextStyle(
                                        color: colorScheme.onSurface
                                            .withOpacity(0.6),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: filteredItems.length,
                                    itemBuilder: (_, i) {
                                      final h = filteredItems[i];
                                      return HistoryCard(
                                        history: h,
                                        onTap: () {},
                                      );
                                    },
                                  ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
