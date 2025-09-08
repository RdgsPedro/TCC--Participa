import 'package:flutter/material.dart';

class CategoriesConfigurationPage extends StatefulWidget {
  const CategoriesConfigurationPage({super.key});

  @override
  State<CategoriesConfigurationPage> createState() =>
      _CategoriesConfigurationPageState();
}

class _CategoriesConfigurationPageState
    extends State<CategoriesConfigurationPage> {
  final List<Map<String, dynamic>> categories = [
    {"name": "Educação", "icon": Icons.school_outlined},
    {"name": "Saúde", "icon": Icons.health_and_safety_outlined},
    {"name": "Política", "icon": Icons.policy_outlined},
    {"name": "Meio Ambiente", "icon": Icons.nature_outlined},
    {"name": "Transporte", "icon": Icons.directions_bus_outlined},
    {"name": "Cultura", "icon": Icons.theater_comedy_outlined},
    {"name": "Segurança", "icon": Icons.security_outlined},
    {"name": "Esportes", "icon": Icons.sports_soccer_outlined},
    {"name": "Tecnologia", "icon": Icons.devices_outlined},
    {"name": "Economia", "icon": Icons.trending_up_outlined},
    {"name": "Moradia", "icon": Icons.house_outlined},
    {"name": "Lazer", "icon": Icons.celebration_outlined},
  ];

  final Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categorias de Interesse",
          style: TextStyle(
            color: cs.tertiary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        backgroundColor: cs.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.tertiary),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: cs.primary),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    "Categorias de Interesse",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                  ),
                  content: Text(
                    "Selecione as categorias que mais te interessam para personalizar sua experiência no app.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: cs.tertiary,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Entendi",
                        style: TextStyle(color: cs.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              border: Border(
                bottom: BorderSide(color: cs.outlineVariant.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.filter_alt_outlined, color: cs.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "CATEGORIAS SELECIONADAS",
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${selected.length} de ${categories.length}",
                    style: TextStyle(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.6,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selected.contains(category["name"]);

                  return _CategoryCard(
                    name: category["name"],
                    icon: category["icon"],
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selected.remove(category["name"]);
                        } else {
                          selected.add(category["name"]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () => setState(() => selected.clear()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cs.error,
                        side: BorderSide(
                          color: cs.error.withOpacity(0.8),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.clear_all, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Limpar",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context, selected.toList());
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Salvar Preferências",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: cs.primary.withOpacity(0.12),
        highlightColor: cs.primary.withOpacity(0.06),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
          decoration: BoxDecoration(
            color: isSelected ? cs.primaryContainer : cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? cs.primary : cs.outlineVariant,
              width: isSelected ? 1.5 : 0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isSelected ? 0.08 : 0.04),
                blurRadius: isSelected ? 6 : 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? cs.primary : cs.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    name,
                    style: textTheme.bodyLarge?.copyWith(
                      color: isSelected ? cs.onPrimaryContainer : cs.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isSelected)
                  Icon(Icons.check_circle, color: cs.primary, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
