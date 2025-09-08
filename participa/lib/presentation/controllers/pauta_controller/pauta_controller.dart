import 'package:flutter/material.dart';
import 'package:participa/domain/UseCase/get_pauta/get_pauta.dart';
import 'package:participa/domain/UseCase/create_pauta/create_pauta.dart';
import 'package:participa/domain/UseCase/delete_pauta/delete_pauta.dart';
import 'package:participa/domain/UseCase/report_pauta/report_pauta.dart';
import 'package:participa/domain/UseCase/add_comment/add_comment.dart';
import 'package:participa/domain/UseCase/report_comment/report_comment.dart';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';

class PautaController extends ChangeNotifier {
  final GetPautas _getPautas;
  final CreatePauta _createPauta;
  final DeletePauta _deletePauta;
  final ReportPauta _reportPauta;
  final AddComment _addComment;
  final ReportComment _reportComment;

  PautaController(
    this._getPautas,
    this._createPauta,
    this._deletePauta,
    this._reportPauta,
    this._addComment,
    this._reportComment,
  );

  List<PautaEntity> items = [];
  bool loading = false;
  String? error;
  int currentIndex = 0;

  Future<void> load() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      items = await _getPautas();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> create(PautaEntity pauta) async {
    try {
      final newPauta = await _createPauta(pauta);
      items.add(newPauta);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> delete(int pautaId) async {
    try {
      await _deletePauta(pautaId);
      items.removeWhere((p) => p.id == pautaId);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> report(int pautaId, String motivo) async {
    try {
      await _reportPauta(pautaId, motivo);
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> addComment(int pautaId, CommentEntity comment) async {
    try {
      final newComment = await _addComment(pautaId, comment);
      final index = items.indexWhere((p) => p.id == pautaId);
      if (index != -1) {
        items[index] = PautaEntity(
          id: items[index].id,
          title: items[index].title,
          image: items[index].image,
          userId: items[index].userId,
          userName: items[index].userName,
          userPhotoUrl: items[index].userPhotoUrl,
          createdAt: items[index].createdAt,
          descriptions: items[index].descriptions,
          comments: [...items[index].comments, newComment],
        );
      }
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> reportComment(int pautaId, int commentId, String motivo) async {
    try {
      await _reportComment(pautaId, commentId, motivo);
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
