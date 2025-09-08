import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:participa/data/repositories/transmissionRepository/transmission_repository_impl.dart';
import 'package:participa/domain/UseCase/getTransmission/get_transmission.dart';
import 'package:participa/presentation/controllers/transmissionController/transmission_controller.dart';
import 'package:participa/presentation/widgets/transmission_card/transmission_card.dart';
import 'package:participa/presentation/widgets/textField/textfield.dart';

class TransmissionPage extends StatefulWidget {
  const TransmissionPage({super.key});

  @override
  State<TransmissionPage> createState() => _TransmissionPageState();
}

class _TransmissionPageState extends State<TransmissionPage> {
  final searchTransmissionController = TextEditingController();
  String searchText = "";

  @override
  void dispose() {
    searchTransmissionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TransmissionController>(
      create: (_) =>
          TransmissionController(GetTransmission(TransmissionRepositoryImpl()))
            ..load(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Transmissões',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Textfield(
                controller: searchTransmissionController,
                hintText: 'Pesquisar',
                obscureText: false,
                icon: Icons.search,
                inputType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                onSubmitted: (value) {},
              ),
              const SizedBox(height: 20),
              TransmissionCard(search: searchText),
            ],
          ),
        ),
      ),
    );
  }
}
