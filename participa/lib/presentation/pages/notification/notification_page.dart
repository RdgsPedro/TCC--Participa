import 'package:flutter/material.dart';
import 'package:participa/presentation/controllers/notification_controller/notification_controller.dart';
import 'package:provider/provider.dart';
import 'package:participa/presentation/widgets/cards_notification/cards_notification.dart';
import 'package:participa/presentation/widgets/filter/filter.dart';
import 'package:participa/data/datasources/notification_datasource/notification_remote_data_source.dart';
import 'package:participa/data/repositories/notification_repository/notification_repository_impl.dart';
import 'package:participa/domain/UseCase/get_notifications/get_notifications.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedCategory = "Todas";

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ChangeNotifierProvider<NotificationController>(
      create: (_) => NotificationController(
        GetNotifications(
          NotificationRepositoryImpl(NotificationRemoteDataSource()),
        ),
      )..fetchNotifications(),

      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.surface,
              elevation: 0,
              scrolledUnderElevation: 0,
              title: Text(
                "Notificações",
                style: TextStyle(
                  color: colorScheme.tertiary,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: IconButton(
                    onPressed: () {
                      _showClearAllDialog(context);
                    },
                    icon: Icon(
                      Icons.delete_outline,
                      color: colorScheme.tertiary,
                    ),
                    tooltip: 'Limpar todas',
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterTabs(
                        options: [
                          "Todas",
                          "Votações",
                          "Notícias",
                          "Transmissões",
                        ],
                        onChanged: (selected) {
                          setState(() {
                            _selectedCategory = selected;
                          });

                          context
                              .read<NotificationController>()
                              .fetchNotifications(category: selected);
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    color: colorScheme.surface.withOpacity(0.7),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context
                            .read<NotificationController>()
                            .fetchNotifications(category: _selectedCategory);
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: CardsNotification(category: _selectedCategory),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Limpar todas as notificações?"),
          content: const Text("Esta ação não pode ser desfeita."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidade em desenvolvimento'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text("Limpar", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
