import 'package:flutter/material.dart';
import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

class OptionVoteButton extends StatelessWidget {
  final OptionVoteEntity option;
  final VoidCallback onPressed;
  final bool isSelected;

  final String? customSubtitle;
  final bool showProgress;
  final double progressValue;

  const OptionVoteButton({
    super.key,
    required this.option,
    required this.onPressed,
    this.isSelected = false,
    this.customSubtitle,
    this.showProgress = false,
    this.progressValue = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withOpacity(0.12)
              : colors.surfaceVariant,
          border: Border.all(
            color: isSelected
                ? colors.primary
                : colors.outline.withOpacity(0.4),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.06),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    option.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? colors.primary : colors.onSurface,
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle,
                          key: const ValueKey("selected"),
                          color: colors.primary,
                          size: 22,
                        )
                      : const SizedBox(key: ValueKey("unselected"), width: 22),
                ),
              ],
            ),
            if (customSubtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                customSubtitle!,
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
              ),
            ],
            if (showProgress) ...[
              const SizedBox(height: 6),
              LinearProgressIndicator(
                value: progressValue,
                minHeight: 8,
                backgroundColor: colors.onSurface.withOpacity(0.1),
                color: colors.primary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
