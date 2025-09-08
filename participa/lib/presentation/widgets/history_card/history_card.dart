import 'package:flutter/material.dart';
import 'package:participa/domain/entities/history_entity/history_entity.dart';

class HistoryCard extends StatelessWidget {
  final HistoryEntity history;
  final VoidCallback onTap;

  const HistoryCard({super.key, required this.history, required this.onTap});

  IconData _icon() {
    final t = (history.type ?? '').toLowerCase();
    switch (t) {
      case 'votacao':
      case 'votação':
        return Icons.how_to_vote_outlined;
      case 'comentario':
      case 'comentário':
        return Icons.mode_comment_outlined;
      case 'pauta':
        return Icons.description_outlined;
      case 'denuncia':
      case 'denúncia':
        return Icons.report_gmailerrorred_outlined;
      default:
        return Icons.history;
    }
  }

  Color _typeColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final t = (history.type ?? '').toLowerCase();

    switch (t) {
      case 'votacao':
      case 'votação':
        return isDark ? Colors.green.shade300 : Colors.green.shade700;
      case 'comentario':
      case 'comentário':
        return isDark ? Colors.teal.shade300 : Colors.teal.shade700;
      case 'pauta':
        return isDark ? Colors.indigo.shade300 : Colors.indigo.shade700;
      case 'denuncia':
      case 'denúncia':
        return isDark ? Colors.red.shade300 : Colors.red.shade700;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _typeTitle() {
    final t = (history.type ?? '').toLowerCase();
    switch (t) {
      case 'votacao':
      case 'votação':
        return 'Votação';
      case 'comentario':
      case 'comentário':
        return 'Comentário';
      case 'pauta':
        return 'Pautas';
      case 'denuncia':
      case 'denúncia':
        return 'Denúncias';
      default:
        return 'Atividade';
    }
  }

  String _dateStr(DateTime? d) {
    if (d == null) return '';
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    final year = d.year.toString();
    return '$day/$month/$year';
  }

  String _actionOrDefault() {
    final action = history.action?.trim() ?? '';
    if (action.isNotEmpty) return action;
    final t = (history.type ?? '').toLowerCase();
    switch (t) {
      case 'votacao':
      case 'votação':
        return 'Você votou';
      case 'comentario':
      case 'comentário':
        return 'Você comentou';
      case 'pauta':
        return 'Você criou uma pauta';
      case 'denuncia':
      case 'denúncia':
        return 'Você denunciou';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _typeColor(context);
    final colors = Theme.of(context).colorScheme;
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return Semantics(
      container: true,
      label: '${_typeTitle()} — ${history.title ?? ''}',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: colors.tertiaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: typeColor.withOpacity(isDark ? 0.15 : 0.10),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 1),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.10 : 0.03),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: typeColor.withOpacity(
                                isDark ? 0.20 : 0.12,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(_icon(), size: 20, color: typeColor),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _typeTitle(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: typeColor,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        _dateStr(history.date),
                        style: TextStyle(
                          fontSize: 12,
                          color: colors.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(
                    color: colors.onSurface.withOpacity(0.12),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        history.title ?? 'Sem título',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurface,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 8),

                      if ((_actionOrDefault()).isNotEmpty) ...[
                        Text(
                          _actionOrDefault(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: typeColor,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 36,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: typeColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Verificar',
                          style: TextStyle(
                            fontSize: 13,
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
      ),
    );
  }
}
