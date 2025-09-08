import 'package:flutter/material.dart';
import 'package:participa/core/theme/app_theme_notifier.dart';

class PreferencesConfigurationPage extends StatelessWidget {
  const PreferencesConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Preferências",
          style: TextStyle(
            color: cs.tertiary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        backgroundColor: cs.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.tertiary),
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.palette_outlined, color: cs.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "APARÊNCIA",
                      style: TextStyle(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: appThemeNotifier,
                  builder: (context, mode, _) {
                    return Column(
                      children: [
                        _ThemeOptionTile(
                          title: "Tema do sistema",
                          subtitle: "Segue as configurações do seu dispositivo",
                          value: ThemeMode.system,
                          groupValue: mode,
                          icon: Icons.phone_iphone_outlined,
                          onChanged: (m) =>
                              appThemeNotifier.value = m ?? ThemeMode.system,
                        ),
                        const SizedBox(height: 8),
                        _ThemeOptionTile(
                          title: "Claro",
                          subtitle: "Usar tema claro",
                          value: ThemeMode.light,
                          groupValue: mode,
                          icon: Icons.wb_sunny_outlined,
                          onChanged: (m) =>
                              appThemeNotifier.value = m ?? ThemeMode.light,
                        ),
                        const SizedBox(height: 8),
                        _ThemeOptionTile(
                          title: "Escuro",
                          subtitle: "Usar tema escuro",
                          value: ThemeMode.dark,
                          groupValue: mode,
                          icon: Icons.nights_stay_outlined,
                          onChanged: (m) =>
                              appThemeNotifier.value = m ?? ThemeMode.dark,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surfaceVariant.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: cs.primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "SOBRE",
                      style: TextStyle(
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.people_alt_outlined, color: cs.onPrimary),
                  ),
                  title: Text("Participa App", style: textTheme.bodyLarge),
                  subtitle: Text(
                    "Versão 1.0.0",
                    style: textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withOpacity(0.6),
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: cs.onSurface.withOpacity(0.4),
                    size: 16,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeOptionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final ThemeMode value;
  final ThemeMode groupValue;
  final IconData icon;
  final Function(ThemeMode?) onChanged;

  const _ThemeOptionTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isSelected = value == groupValue;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? cs.primary.withOpacity(0.1) : cs.surface,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? Border.all(color: cs.primary, width: 1.5) : null,
      ),
      child: RadioListTile(
        title: Text(title, style: textTheme.bodyLarge),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: cs.onSurface.withOpacity(0.6),
          ),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        secondary: Icon(icon, color: isSelected ? cs.primary : cs.onSurface),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        activeColor: cs.primary,
        dense: true,
      ),
    );
  }
}
