import 'package:flutter/material.dart';
import 'package:participa/presentation/pages/configuration/notifications_configuration_page.dart';
import 'package:participa/presentation/pages/configuration/preferences_configuration_page.dart';
import 'package:participa/presentation/pages/participation_history/participation_history_page.dart';
import 'package:participa/presentation/pages/profile/profile_page.dart';
import 'categories_configuration_page.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: cs.tertiary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Configurações",
          style: TextStyle(
            color: cs.tertiary,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/527"),
                ),
                const SizedBox(height: 12),
                Text(
                  "Pedro Rodrigues Almeida",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: cs.tertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildOption(
            icon: Icons.person_outline,
            text: "Dados Pessoais",
            cs: cs,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            ),
          ),
          _buildOption(
            icon: Icons.group_outlined,
            text: "Participações",
            cs: cs,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ParticipationHistoryPage(),
              ),
            ),
          ),
          _buildOption(
            icon: Icons.notifications_outlined,
            text: "Notificações",
            cs: cs,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationsConfigurationPage(),
              ),
            ),
          ),
          _buildOption(
            icon: Icons.settings_outlined,
            text: "Preferências",
            cs: cs,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PreferencesConfigurationPage(),
              ),
            ),
          ),
          _buildOption(
            icon: Icons.category_outlined,
            text: "Categorias de Interesse",
            cs: cs,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CategoriesConfigurationPage(),
              ),
            ),
          ),
          _buildOption(
            icon: Icons.logout,
            text: "Sair",
            cs: cs,
            onTap: () => _showLogoutDialog(context, cs),
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String text,
    required ColorScheme cs,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: cs.tertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: cs.primary),
        title: Text(
          text,
          style: TextStyle(color: cs.tertiary, fontWeight: FontWeight.w600),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: cs.tertiary),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ColorScheme cs) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Text(
                "Sair",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: cs.primary,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                "Você realmente quer sair?",
                style: TextStyle(fontSize: 16, color: cs.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: cs.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancelar",
                        style: TextStyle(
                          color: cs.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil('/', (route) => false);
                      },
                      child: const Text(
                        "Sim, sair",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
