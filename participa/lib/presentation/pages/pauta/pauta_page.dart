import 'package:flutter/material.dart';
import 'package:participa/presentation/controllers/pauta_controller/pauta_controller.dart';
import 'package:participa/presentation/widgets/pauta_cards.dart/pauta_cards.dart';
import 'package:provider/provider.dart';

import 'package:participa/domain/UseCase/get_pauta/get_pauta.dart';
import 'package:participa/domain/UseCase/create_pauta/create_pauta.dart';
import 'package:participa/domain/UseCase/delete_pauta/delete_pauta.dart';
import 'package:participa/domain/UseCase/report_pauta/report_pauta.dart';
import 'package:participa/domain/UseCase/add_comment/add_comment.dart';
import 'package:participa/domain/UseCase/report_comment/report_comment.dart';
import 'package:participa/data/repositories/pauta_repository/pauta_repository_impl.dart';
import 'package:participa/data/datasources/pauta_datasource/pauta_remote_data_source.dart';
import 'package:participa/presentation/pages/add_pauta/add_pauta.dart';
import 'package:participa/presentation/widgets/filter/filter.dart';
import 'package:participa/presentation/widgets/textfield/textfield.dart';

class PautaPage extends StatefulWidget {
  const PautaPage({super.key});

  @override
  State<PautaPage> createState() => _PautaPageState();
}

class _PautaPageState extends State<PautaPage> {
  final searchController = TextEditingController();
  String searchText = "";
  String _selectedCategory = "Todas as Pautas";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PautaController>(
      create: (_) => PautaController(
        GetPautas(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
        CreatePauta(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
        DeletePauta(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
        ReportPauta(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
        AddComment(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
        ReportComment(PautaRepositoryImpl(PautaRemoteDataSourceImpl())),
      )..load(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            "Pautas",
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
          scrolledUnderElevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPautaPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                child: const Text("Adicionar"),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Textfield(
                controller: searchController,
                hintText: "Pesquisar",
                obscureText: false,
                icon: Icons.search,
                inputType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() => searchText = value);
                },
                onSubmitted: (_) {},
              ),
              const SizedBox(height: 15),
              FilterTabs(
                options: ["Todas as Pautas", "Minhas Pautas"],
                onChanged: (selected) {
                  setState(() => _selectedCategory = selected);
                },
              ),
              PautaCards(search: searchText, category: _selectedCategory),
            ],
          ),
        ),
      ),
    );
  }
}
