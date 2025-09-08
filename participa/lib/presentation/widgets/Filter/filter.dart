import 'package:flutter/material.dart';

class FilterTabs extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String> onChanged;
  final int initialIndex;
  final int maxVisibleWithoutScroll;

  const FilterTabs({
    super.key,
    required this.options,
    required this.onChanged,
    this.initialIndex = 0,
    this.maxVisibleWithoutScroll = 3,
  });

  @override
  State<FilterTabs> createState() => _FilterTabsState();
}

class _FilterTabsState extends State<FilterTabs> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final hasFewOptions =
        widget.options.length <= widget.maxVisibleWithoutScroll;

    final content = Row(
      mainAxisAlignment: hasFewOptions
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: _buildTabs(context),
    );

    return SizedBox(
      height: 48,
      child: hasFewOptions
          ? content
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: content,
            ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    List<Widget> tabs = [];

    for (int i = 0; i < widget.options.length; i++) {
      final text = widget.options[i];
      final isSelected = selectedIndex == i;

      tabs.add(
        GestureDetector(
          onTap: () {
            setState(() => selectedIndex = i);
            widget.onChanged(text);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? colors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colors.primary.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      );

      if (i < widget.options.length - 1) {
        tabs.add(
          Container(
            width: 1,
            height: 24,
            color: colors.outlineVariant.withOpacity(0.3),
          ),
        );
      }
    }

    return tabs;
  }
}
