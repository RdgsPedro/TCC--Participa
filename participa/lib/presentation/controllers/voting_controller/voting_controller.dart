import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:participa/data/datasources/voting_datasource/voting_remote_data_source.dart';
import 'package:participa/data/repositories/voting_repository/voting_repository_impl.dart';
import 'package:participa/domain/UseCase/get_voting/get_voting.dart';
import 'package:participa/domain/UseCase/send_vote/send_vote.dart';

import 'package:participa/domain/entities/voting_entity/voting_entity.dart';

class VotingController extends ChangeNotifier {
  final GetVoting _getVoting;
  final SendVote _sendVote;

  VotingController(this._getVoting, this._sendVote);

  List<VotingEntity> items = [];
  bool loading = false;
  String? error;
  int currentIndex = 0;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      items = await _getVoting();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> vote(int votingId, int optionId) async {
    try {
      await _sendVote(votingId, optionId);
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  void setIndex(int i) {
    currentIndex = i;
    notifyListeners();
  }
}

class VotingPage extends StatelessWidget {
  const VotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VotingController>(
      create: (_) => VotingController(
        GetVoting(VotingRepositoryImpl(VotingRemoteDataSourceImpl())),
        SendVote(VotingRepositoryImpl(VotingRemoteDataSourceImpl())),
      )..load(),
      child: const VotingPage(),
    );
  }
}
