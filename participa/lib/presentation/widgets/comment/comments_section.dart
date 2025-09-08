import 'dart:math';

import 'package:flutter/material.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/presentation/widgets/comment/comment_item.dart';

class CommentsSection extends StatefulWidget {
  final List<CommentEntity> comments;
  final Set<int> likedCommentIds;
  final Map<int, int> commentLikes;
  final void Function(CommentEntity) onLike;
  final void Function(CommentEntity) onReplyTap;
  final void Function(CommentEntity) onReportTap;
  final String Function(DateTime) formatTimeAgo;

  const CommentsSection({
    super.key,
    required this.comments,
    required this.likedCommentIds,
    required this.commentLikes,
    required this.onLike,
    required this.onReplyTap,
    required this.onReportTap,
    required this.formatTimeAgo,
  });

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection>
    with TickerProviderStateMixin {
  bool _showAll = false;

  final Set<int> _expandedRepliesIds = {};

  static const int kDefaultVisibleComments = 5;

  static const Duration kAnimDuration = Duration(milliseconds: 250);
  static const Curve kAnimCurve = Curves.easeInOut;

  void _toggleRepliesExpanded(int commentId) {
    setState(() {
      if (_expandedRepliesIds.contains(commentId)) {
        _expandedRepliesIds.remove(commentId);
      } else {
        _expandedRepliesIds.add(commentId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dividerOpacity = 0.12;
    final double dividerThickness = 1.0;
    final double dividerHeight = 16.0;

    final double dividerIndent = 56.0;

    final Color dividerColor = Theme.of(
      context,
    ).dividerColor.withOpacity(dividerOpacity);

    final visibleCount = _showAll
        ? widget.comments.length
        : (widget.comments.isEmpty
              ? 0
              : min(kDefaultVisibleComments, widget.comments.length));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: dividerThickness, color: dividerColor, height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Comentários (${widget.comments.length})",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              if (widget.comments.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() => _showAll = !_showAll);
                  },
                  child: AnimatedSwitcher(
                    duration: kAnimDuration,
                    switchInCurve: kAnimCurve,
                    switchOutCurve: kAnimCurve,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      _showAll
                          ? "Ver menos"
                          : "Ver todos (${widget.comments.length})",
                      key: ValueKey<bool>(_showAll),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (widget.comments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: Text(
                  "Nenhum comentário ainda. Seja o primeiro a comentar!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            AnimatedSize(
              duration: kAnimDuration,
              curve: kAnimCurve,
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: visibleCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  final comment = widget.comments[index];

                  final replies = comment.replies ?? <CommentEntity>[];
                  final totalReplies = replies.length;
                  final isExpanded = _expandedRepliesIds.contains(comment.id);

                  final showToggleForReplies = totalReplies > 0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommentItem(
                        comment: comment,
                        isReply: false,
                        isLiked: widget.likedCommentIds.contains(comment.id),
                        likeCount: widget.commentLikes[comment.id] ?? 0,
                        onLike: widget.onLike,
                        onReply: widget.onReplyTap,
                        onReport: widget.onReportTap,
                        formatTimeAgo: widget.formatTimeAgo,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Column(
                            children: [
                              const SizedBox(height: 8),
                              ...replies.map(
                                (reply) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: CommentItem(
                                    comment: reply,
                                    isReply: true,
                                    isLiked: widget.likedCommentIds.contains(
                                      reply.id,
                                    ),
                                    likeCount:
                                        widget.commentLikes[reply.id] ?? 0,
                                    onLike: widget.onLike,
                                    onReply: widget.onReplyTap,
                                    onReport: widget.onReportTap,
                                    formatTimeAgo: widget.formatTimeAgo,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: kAnimDuration,
                          firstCurve: kAnimCurve,
                          secondCurve: kAnimCurve,
                          sizeCurve: kAnimCurve,
                        ),
                      ),

                      if (showToggleForReplies)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () =>
                                  _toggleRepliesExpanded(comment.id),
                              child: Text(
                                isExpanded
                                    ? "Ver menos respostas"
                                    : (totalReplies == 1
                                          ? "Ver resposta"
                                          : "Ver respostas ($totalReplies)"),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                      Divider(
                        height: dividerHeight,
                        thickness: dividerThickness,
                        color: dividerColor,
                        indent: dividerIndent,
                      ),
                    ],
                  );
                },
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
