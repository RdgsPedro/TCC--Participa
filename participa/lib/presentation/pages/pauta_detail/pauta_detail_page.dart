import 'package:flutter/material.dart';
import 'package:participa/domain/entities/pauta_entity/pauta_entity.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/presentation/widgets/cards_information/cards_information.dart';
import 'package:participa/presentation/widgets/comment/bottom_comment_bar.dart';
import 'package:participa/presentation/widgets/comment/comments_section.dart';

typedef ReportSubmit = Future<bool> Function(String reason, String description);

class ReportDialog extends StatefulWidget {
  final String title;
  final String? subtitle;
  final ReportSubmit submitReport;
  final List<String> reasons;

  const ReportDialog({
    Key? key,
    required this.title,
    this.subtitle,
    required this.submitReport,
    this.reasons = const [
      "Conteúdo ofensivo",
      "Spam / Publicidade",
      "Discurso de ódio",
      "Informação falsa",
      "Outro",
    ],
  }) : super(key: key);

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog>
    with TickerProviderStateMixin {
  String? _selectedReason;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSuccess = false;
  String? _errorMessage;

  late final AnimationController _successController;
  late final Animation<double> _successScale;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    _successScale = CurvedAnimation(
      parent: _successController,
      curve: Curves.elasticOut,
    );

    _descriptionController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _successController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (_selectedReason == null || _descriptionController.text.trim().isEmpty)
      return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final success = await widget.submitReport(
        _selectedReason!,
        _descriptionController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        setState(() {
          _isSuccess = true;
        });
        await _successController.forward();

        await Future.delayed(const Duration(milliseconds: 700));
        if (!mounted) return;
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _errorMessage = "Erro ao enviar denúncia. Tente novamente.";
          _isSubmitting = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            "Erro de rede. Verifique sua conexão e tente novamente.";
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isSuccess) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _successScale,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 42),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Denúncia enviada",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Agradecemos a sua contribuição. Nossa equipe analisará o conteúdo.",
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.subtitle!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Motivo da denúncia",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: _selectedReason,
                    items: widget.reasons
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: _isSubmitting
                        ? null
                        : (v) => setState(() => _selectedReason = v),
                    decoration: InputDecoration(
                      hintText: "Selecione um motivo",
                      filled: true,
                      fillColor: theme.colorScheme.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Descrição da denúncia",
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 120,
                    maxHeight: 220,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 14,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    enabled: !_isSubmitting,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Descreva detalhadamente o motivo da denúncia",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(14),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                const SizedBox(height: 6),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _isSubmitting
                            ? null
                            : () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          "CANCELAR",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            (_selectedReason != null &&
                                _descriptionController.text.trim().isNotEmpty &&
                                !_isSubmitting)
                            ? _handleSubmit
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: theme.colorScheme.primary,
                          disabledBackgroundColor: theme.colorScheme.primary,
                        ),
                        child: _isSubmitting
                            ? SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                "ENVIAR",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            right: 4,
            top: 4,
            child: IconButton(
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              icon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
              onPressed: _isSubmitting
                  ? null
                  : () => Navigator.of(context).pop(false),
            ),
          ),
        ],
      ),
    );
  }
}

class PautaDetailPage extends StatefulWidget {
  final PautaEntity pauta;

  const PautaDetailPage({super.key, required this.pauta});

  @override
  State<PautaDetailPage> createState() => _PautaDetailPageState();
}

class _PautaDetailPageState extends State<PautaDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  late Map<int, int> _commentLikes;
  late Set<int> _likedCommentIds;
  late List<CommentEntity> _comments;

  @override
  void initState() {
    super.initState();
    _comments = List.from(widget.pauta.comments);
    _commentLikes = {for (var comment in _getAllComments()) comment.id: 0};
    _likedCommentIds = {};
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  List<CommentEntity> _getAllComments() {
    final allComments = <CommentEntity>[];
    for (var comment in _comments) {
      allComments.add(comment);
      allComments.addAll(comment.replies);
    }
    return allComments;
  }

  void _toggleCommentLike(CommentEntity comment) {
    setState(() {
      final isLiked = _likedCommentIds.contains(comment.id);
      if (isLiked) {
        _likedCommentIds.remove(comment.id);
        _commentLikes.update(
          comment.id,
          (value) => value - 1,
          ifAbsent: () => 0,
        );
      } else {
        _likedCommentIds.add(comment.id);
        _commentLikes.update(
          comment.id,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    });
  }

  String _formatTimeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);
    if (difference.inDays > 0) return 'há ${difference.inDays} d';
    if (difference.inHours > 0) return 'há ${difference.inHours} h';
    if (difference.inMinutes > 0) return 'há ${difference.inMinutes} min';
    return 'agora mesmo';
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      final newComment = CommentEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: "currentUser",
        userName: "Você",
        userPhotoUrl: "https://randomuser.me/api/portraits/lego/1.jpg",
        text: _commentController.text.trim(),
        createdAt: DateTime.now(),
        replies: [],
      );
      _comments.insert(0, newComment);
      _commentLikes[newComment.id] = 0;
      _commentController.clear();
      _commentFocusNode.unfocus();
    });
  }

  void _addReply(CommentEntity parentComment, String text) {
    setState(() {
      final newReply = CommentEntity(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: "currentUser",
        userName: "Você",
        userPhotoUrl: "https://randomuser.me/api/portraits/lego/1.jpg",
        text: text,
        createdAt: DateTime.now(),
        replies: [],
      );

      final parentIndex = _comments.indexWhere((c) => c.id == parentComment.id);
      if (parentIndex != -1) {
        _comments[parentIndex] = CommentEntity(
          id: parentComment.id,
          userId: parentComment.userId,
          userName: parentComment.userName,
          userPhotoUrl: parentComment.userPhotoUrl,
          text: parentComment.text,
          createdAt: parentComment.createdAt,
          replies: [...parentComment.replies, newReply],
        );
      }

      _commentLikes[newReply.id] = 0;
    });
  }

  void _showReplySheet(CommentEntity parentComment) {
    final replyController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.reply,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Respondendo a ${parentComment.userName}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    parentComment.text,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: replyController,
                  autofocus: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Escreva sua resposta...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("CANCELAR"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (replyController.text.trim().isNotEmpty) {
                            _addReply(
                              parentComment,
                              replyController.text.trim(),
                            );
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("RESPONDER"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _reportPauta() {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (ctx) => ReportDialog(
        title: "Denunciar pauta",
        submitReport: (reason, description) async {
          await Future.delayed(const Duration(seconds: 1));
          return true;
        },
      ),
    );
  }

  void _reportComment(CommentEntity comment) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (ctx) => ReportDialog(
        title: "Denunciar comentário",
        subtitle: "Deseja denunciar o comentário de ${comment.userName}?",
        submitReport: (reason, description) async {
          await Future.delayed(const Duration(seconds: 1)); //
          return true;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pauta = widget.pauta;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _reportPauta,
            icon: const Icon(Icons.flag_outlined, color: Colors.redAccent),
            tooltip: "Denunciar pauta",
          ),
        ],
        scrolledUnderElevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      pauta.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 500,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(pauta.userPhotoUrl),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pauta.userName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${pauta.createdAt.day}/${pauta.createdAt.month}/${pauta.createdAt.year} "
                              "${pauta.createdAt.hour.toString().padLeft(2, '0')}:${pauta.createdAt.minute.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Sobre a pauta",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: pauta.descriptions.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final desc = pauta.descriptions[index];
                        return CardsInformation(
                          title: desc.title,
                          description: desc.info,
                        );
                      },
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 40,
                ),
                child: CommentsSection(
                  comments: _comments,
                  likedCommentIds: _likedCommentIds,
                  commentLikes: _commentLikes,
                  onLike: _toggleCommentLike,
                  onReplyTap: _showReplySheet,
                  onReportTap: _reportComment,
                  formatTimeAgo: _formatTimeAgo,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: BottomCommentBar(
          controller: _commentController,
          onSend: _addComment,
        ),
      ),
    );
  }
}
