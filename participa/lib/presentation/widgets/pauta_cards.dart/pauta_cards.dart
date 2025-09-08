import 'package:flutter/material.dart';
import 'package:participa/presentation/controllers/pauta_controller/pauta_controller.dart';
import 'package:provider/provider.dart';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/presentation/pages/pauta_detail/pauta_detail_page.dart';

class PautaCards extends StatelessWidget {
  final String search;
  final String? category;

  const PautaCards({super.key, required this.search, this.category});

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  void _openDetail(BuildContext context, PautaEntity pauta) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PautaDetailPage(pauta: pauta)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer<PautaController>(
      builder: (context, controller, _) {
        if (controller.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error != null) {
          return Center(child: Text("Erro: ${controller.error}"));
        }

        if (controller.items.isEmpty) {
          return const Center(child: Text("Nenhuma pauta encontrada"));
        }

        final query = search.trim().toLowerCase();
        final categoryLower = category?.trim().toLowerCase();

        final pautas = controller.items.where((p) {
          final title = p.title.toLowerCase();
          final autor = p.userName.toLowerCase();

          final matchSearch =
              query.isEmpty || title.contains(query) || autor.contains(query);

          final matchCategory = switch (categoryLower) {
            null || "todas as pautas" => true,
            "minhas pautas" => p.userId == "CURRENT_USER_ID",
            _ => true,
          };

          return matchSearch && matchCategory;
        }).toList();

        if (pautas.isEmpty) {
          return const Center(
            child: Text("Nenhum resultado para sua pesquisa"),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(12),
          itemCount: pautas.length,
          itemBuilder: (context, i) {
            final pauta = pautas[i];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: colors.tertiaryContainer,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => _openDetail(context, pauta),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          pauta.image.isNotEmpty
                              ? pauta.image
                              : "https://via.placeholder.com/600x180?text=Participa",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 160,
                            color: colors.tertiaryContainer,
                            child: Icon(
                              Icons.image_not_supported,
                              color: colors.onSurfaceVariant,
                              size: 40,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 12,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  pauta.userPhotoUrl,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  pauta.userName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pauta.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.primary,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: colors.tertiary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Criada em ${_formatDate(pauta.createdAt)}",
                                style: TextStyle(
                                  color: colors.tertiary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          if (pauta.descriptions.isNotEmpty)
                            Text(
                              pauta.descriptions.first.info,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: colors.onSurface.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),

                          const SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.comment,
                                    size: 16,
                                    color: colors.tertiary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${pauta.comments.length} comentários",
                                    style: TextStyle(
                                      color: colors.tertiary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () => _openDetail(context, pauta),
                                child: const Text(
                                  "Ver Detalhes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
