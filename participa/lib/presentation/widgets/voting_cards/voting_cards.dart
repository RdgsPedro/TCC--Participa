import 'package:flutter/material.dart';
import 'package:participa/domain/entities/description_entity/description_entity.dart';
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';
import 'package:participa/presentation/controllers/voting_controller/voting_controller.dart';
import 'package:participa/presentation/pages/voting_detail/voting_detail_page.dart';
import 'package:provider/provider.dart';

class VotingCards extends StatelessWidget {
  final String search;
  final String? category;

  const VotingCards({super.key, required this.search, this.category});

  Map<String, dynamic> _getStatusStyle(String? status) {
    final s = status?.toLowerCase() ?? "";
    if (["active", "aberta", "em andamento"].contains(s)) {
      return {'color': Colors.green, 'icon': Icons.play_circle_fill};
    }
    if (["closed", "encerrada", "fechada"].contains(s)) {
      return {'color': Colors.red, 'icon': Icons.check_circle};
    }
    return {'color': null, 'icon': Icons.info};
  }

  String _getFirstDescription(List<dynamic>? descriptions) {
    if (descriptions == null || descriptions.isEmpty) {
      return 'Participe desta votação importante';
    }

    for (final d in descriptions) {
      if (d == null) continue;

      if (d is String && d.trim().isNotEmpty) return d.trim();

      if (d is DescriptionEntity && d.info.trim().isNotEmpty) {
        return d.info.trim();
      }

      if (d is Map) {
        for (final key in ['info', 'text', 'description', 'desc', 'value']) {
          final value = d[key]?.toString();
          if (value != null &&
              value.trim().isNotEmpty &&
              !value.startsWith('Instance of')) {
            return value.trim();
          }
        }
      }
    }

    return 'Participe desta votação importante';
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return '';
    final parts = dateString.split('-');
    return parts.length == 3
        ? '${parts[2]}/${parts[1]}/${parts[0]}'
        : dateString;
  }

  String? _getTag(dynamic tag) => tag is String
      ? tag
      : tag is Map
      ? tag['name']?.toString()
      : tag?.toString();

  @override
  Widget build(BuildContext context) {
    VotingController? maybeController;
    try {
      maybeController = Provider.of<VotingController>(context, listen: false);
    } catch (_) {
      return const Center(
        child: Text(
          "Erro: VotingController não encontrado. Use VotingPage (que providencia o controller).",
        ),
      );
    }

    final loading = context.select((VotingController c) => c.loading);
    final error = context.select((VotingController c) => c.error);
    final items = context.select((VotingController c) => c.items);

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text("Erro: $error"));
    }
    if (items.isEmpty) {
      return const Center(child: Text("Nenhuma votação encontrada"));
    }

    final query = search.trim().toLowerCase();
    final cat = category?.trim().toLowerCase();

    final votings = items.where((v) {
      final title = v.title.toLowerCase();
      final tag = _getTag(v.tag)?.toLowerCase() ?? "";
      final status = v.status?.toLowerCase() ?? "";

      final matchSearch =
          query.isEmpty || title.contains(query) || tag.contains(query);

      final matchCategory = switch (cat) {
        null || "todas" => true,
        "aberta" => ["aberta", "active", "em andamento"].contains(status),
        "encerrada" => ["encerrada", "closed", "fechada"].contains(status),
        _ => tag == cat,
      };

      return matchSearch && matchCategory;
    }).toList();

    if (votings.isEmpty) {
      return const Center(child: Text("Nenhum resultado para sua pesquisa"));
    }

    void openVotingDetail(VotingEntity voting) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VotingDetailPage(voting: voting)),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: votings.length,
      itemBuilder: (context, i) {
        final v = votings[i];
        final statusMap = _getStatusStyle(v.status);
        final statusColor = (statusMap['color'] as Color?) ?? colors.primary;
        final statusIcon = statusMap['icon'] as IconData;

        final tag = _getTag(v.tag);

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: colors.tertiaryContainer,
          margin: const EdgeInsets.only(bottom: 16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => openVotingDetail(v),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          (v.image ?? "").isNotEmpty
                              ? v.image!
                              : "https://via.placeholder.com/400x200?text=Participa",
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: double.infinity,
                            height: 160,
                            color: colors.surfaceVariant,
                            child: Icon(
                              Icons.image_not_supported,
                              color: colors.onSurfaceVariant,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                (v.status ?? '').toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (tag?.isNotEmpty ?? false)
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primary.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              tag!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    v.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getFirstDescription(v.descriptions),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.tertiary),
                  ),
                  const SizedBox(height: 12),
                  if ((v.startDate ?? '').isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: colors.tertiary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_formatDate(v.startDate)}${(v.endDate ?? '').isNotEmpty ? ' - ${_formatDate(v.endDate)}' : ''}',
                          style: TextStyle(
                            color: colors.tertiary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => openVotingDetail(v),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        "Participar da Votação",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
