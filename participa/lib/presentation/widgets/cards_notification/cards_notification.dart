import 'package:flutter/material.dart';
import 'package:participa/presentation/controllers/notification_controller/notification_controller.dart';
import 'package:provider/provider.dart';
import 'package:participa/domain/entities/notification_entity.dart/notification_entity.dart';

class CardsNotification extends StatelessWidget {
  final String category;

  const CardsNotification({super.key, required this.category});

  List<NotificationEntity> _sectionToday(List<NotificationEntity> list) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return list.where((n) => n.timestamp.isAfter(startOfDay)).toList();
  }

  List<NotificationEntity> _sectionThisWeek(List<NotificationEntity> list) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(const Duration(days: 6));
    final startOfDay = DateTime(now.year, now.month, now.day);

    return list.where((n) {
      return n.timestamp.isAfter(startOfWeek) &&
          n.timestamp.isBefore(startOfDay);
    }).toList();
  }

  String _relativeTime(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'agora';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}';
  }

  Widget _buildCard(
    BuildContext context,
    NotificationEntity item,
    bool isLast,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isDark = colorScheme.brightness == Brightness.dark;

    IconData icon;
    Color typeColor;
    String typeText;

    switch (item.type) {
      case 'news':
        icon = Icons.article_outlined;
        typeColor = isDark ? Colors.blue[200]! : Colors.blue[700]!;
        typeText = 'Notícia';
        break;
      case 'transmission':
        icon = Icons.live_tv_outlined;
        typeColor = isDark ? Colors.red[200]! : Colors.red[700]!;
        typeText = 'Transmissão';
        break;
      case 'voting':
        icon = Icons.how_to_vote_outlined;
        typeColor = isDark ? Colors.purple[200]! : Colors.purple[700]!;
        typeText = 'Votação';
        break;
      case 'comment':
        icon = Icons.comment_outlined;
        typeColor = isDark ? Colors.orange[200]! : Colors.orange[700]!;
        typeText = 'Comentário';
        break;
      default:
        icon = Icons.notifications_none;
        typeColor = colorScheme.primary;
        typeText = 'Notificação';
    }

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          highlightColor: colorScheme.primary.withOpacity(0.05),
          splashColor: colorScheme.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(icon, color: typeColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            typeText,
                            style: TextStyle(
                              fontSize: 12,
                              color: typeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _relativeTime(item.timestamp),
                      style: TextStyle(
                        color: colorScheme.onSurface.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  item.title,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.message,
                  style: TextStyle(
                    color: colorScheme.onSurface.withOpacity(0.8),
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                if (item.type == 'voting' || item.type == 'transmission')
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: item.type == 'voting'
                          ? TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: typeColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text(
                                'Participar',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : TextButton.icon(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: typeColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              icon: const Icon(Icons.play_arrow, size: 18),
                              label: const Text(
                                'Assistir',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, int count) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.8),
              fontWeight: FontWeight.w700,
              fontSize: 18,
              letterSpacing: -0.3,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.errorMessage != null) {
          return Center(child: Text('Erro: ${controller.errorMessage}'));
        }

        final _filtered = controller.notifications;

        if (_filtered.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma notificação',
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.5),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Quando houver novas notificações,\nelas aparecerão aqui.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.4),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final today = _sectionToday(_filtered);
        final thisWeek = _sectionThisWeek(_filtered);
        final earlier = _filtered.where((n) {
          final now = DateTime.now();
          final startOfWeek = now.subtract(const Duration(days: 7));
          return n.timestamp.isBefore(startOfWeek);
        }).toList();

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (today.isNotEmpty) ...[
                _buildSectionHeader(context, 'Hoje', today.length),
                ...List.generate(
                  today.length,
                  (index) => _buildCard(
                    context,
                    today[index],
                    index == today.length - 1,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (thisWeek.isNotEmpty) ...[
                _buildSectionHeader(context, 'Esta semana', thisWeek.length),
                ...List.generate(
                  thisWeek.length,
                  (index) => _buildCard(
                    context,
                    thisWeek[index],
                    index == thisWeek.length - 1,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (earlier.isNotEmpty) ...[
                _buildSectionHeader(context, 'Mais antigas', earlier.length),
                ...List.generate(
                  earlier.length,
                  (index) => _buildCard(
                    context,
                    earlier[index],
                    index == earlier.length - 1,
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
