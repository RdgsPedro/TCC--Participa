import 'package:flutter/material.dart';

class NotificationsConfigurationPage extends StatefulWidget {
  const NotificationsConfigurationPage({super.key});

  @override
  State<NotificationsConfigurationPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsConfigurationPage> {
  bool notifyVote = true;
  bool notifyNews = false;
  bool notifyStream = true;
  bool notifyComments = false;
  bool notificationSound = true;
  bool notificationVibration = true;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notificações",
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
      backgroundColor: cs.surface,
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
                    Icon(
                      Icons.notifications_active_outlined,
                      color: cs.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "TIPOS DE NOTIFICAÇÃO",
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
                _NotificationOption(
                  title: "Nova votação",
                  subtitle:
                      "Receba alertas quando novas votações estiverem disponíveis",
                  icon: Icons.how_to_vote_outlined,
                  value: notifyVote,
                  onChanged: (v) => setState(() => notifyVote = v),
                ),
                const SizedBox(height: 12),
                _NotificationOption(
                  title: "Nova notícia",
                  subtitle: "Seja notificado sobre novidades e atualizações",
                  icon: Icons.article_outlined,
                  value: notifyNews,
                  onChanged: (v) => setState(() => notifyNews = v),
                ),
                const SizedBox(height: 12),
                _NotificationOption(
                  title: "Nova transmissão",
                  subtitle: "Alertas sobre transmissões ao vivo programadas",
                  icon: Icons.video_camera_back_outlined,
                  value: notifyStream,
                  onChanged: (v) => setState(() => notifyStream = v),
                ),
                const SizedBox(height: 12),
                _NotificationOption(
                  title: "Comentários em pautas",
                  subtitle: "Notificações sobre novas interações em discussões",
                  icon: Icons.comment_outlined,
                  value: notifyComments,
                  onChanged: (v) => setState(() => notifyComments = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

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
                    Icon(
                      Icons.settings_suggest_outlined,
                      color: cs.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "PREFERÊNCIAS DE NOTIFICAÇÃO",
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
                _NotificationPreference(
                  title: "Som",
                  subtitle: "Reproduzir som ao receber notificações",
                  icon: Icons.volume_up,
                  value: notificationSound,
                  onChanged: (v) => setState(() => notificationSound = v),
                ),
                const SizedBox(height: 12),
                _NotificationPreference(
                  title: "Vibração",
                  subtitle: "Vibrar ao receber notificações",
                  icon: Icons.vibration,
                  value: notificationVibration,
                  onChanged: (v) => setState(() => notificationVibration = v),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cs.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.schedule, color: cs.primary),
                  ),
                  title: Text(
                    "Horário de notificação",
                    style: textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    "Definir horários para receber notificações",
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _NotificationOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final Function(bool) onChanged;

  const _NotificationOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SwitchListTile(
        title: Text(title, style: textTheme.bodyLarge),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: cs.onSurface.withOpacity(0.6),
          ),
        ),
        value: value,
        onChanged: onChanged,
        secondary: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cs.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: cs.primary, size: 20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}

class _NotificationPreference extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final Function(bool) onChanged;

  const _NotificationPreference({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SwitchListTile(
        title: Text(title, style: textTheme.bodyLarge),
        subtitle: Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: cs.onSurface.withOpacity(0.6),
          ),
        ),
        value: value,
        onChanged: onChanged,
        secondary: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: cs.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: cs.primary, size: 20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}
