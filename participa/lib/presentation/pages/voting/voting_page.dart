import 'package:flutter/material.dart';
import 'package:participa/data/datasources/voting_datasource/voting_remote_data_source.dart';
import 'package:provider/provider.dart';
import 'package:participa/presentation/controllers/voting_controller/voting_controller.dart';
import 'package:participa/data/repositories/voting_repository/voting_repository_impl.dart';
import 'package:participa/domain/UseCase/get_voting/get_voting.dart';
import 'package:participa/domain/UseCase/send_vote/send_vote.dart';

import 'package:participa/presentation/widgets/filter/filter.dart';
import 'package:participa/presentation/widgets/textfield/textfield.dart';
import 'package:participa/presentation/widgets/voting_cards/voting_cards.dart';

class VotingPage extends StatefulWidget {
  const VotingPage({super.key});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  final searchVotingController = TextEditingController();
  String searchText = "";
  String _selectedCategory = "Aberta";

  @override
  void dispose() {
    searchVotingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VotingController>(
      create: (_) => VotingController(
        GetVoting(VotingRepositoryImpl(VotingRemoteDataSourceImpl())),
        SendVote(VotingRepositoryImpl(VotingRemoteDataSourceImpl())),
      )..load(),
      child: Consumer<VotingController>(
        builder: (context, controller, _) {
          final cs = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: cs.surface,
            appBar: AppBar(
              backgroundColor: cs.surface,
              title: Text(
                "Propostas de Votação",
                style: TextStyle(
                  color: cs.tertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              scrolledUnderElevation: 0,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Textfield(
                    controller: searchVotingController,
                    hintText: "Pesquisar",
                    obscureText: false,
                    icon: Icons.search,
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                  ),

                  const SizedBox(height: 15),

                  FilterTabs(
                    options: ["Aberta", "Encerrada"],
                    onChanged: (selected) {
                      setState(() {
                        _selectedCategory = selected;
                      });
                    },
                  ),

                  VotingCards(search: searchText, category: _selectedCategory),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
