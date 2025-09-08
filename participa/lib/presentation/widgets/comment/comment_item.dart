import 'package:flutter/material.dart';
import 'package:participa/domain/entities/comment_entity/comment_entity.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity comment;
  final bool isReply;
  final bool isLiked;
  final int likeCount;
  final void Function(CommentEntity) onLike;
  final void Function(CommentEntity) onReply;
  final void Function(CommentEntity) onReport;
  final String Function(DateTime) formatTimeAgo;

  const CommentItem({
    super.key,
    required this.comment,
    this.isReply = false,
    required this.isLiked,
    required this.likeCount,
    required this.onLike,
    required this.onReply,
    required this.onReport,
    required this.formatTimeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? 28.0 : 0.0,
        top: 12.0,
        bottom: 12.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(comment.userPhotoUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        comment.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.flag_outlined,
                        color: Colors.red,
                        size: 25,
                      ),
                      onPressed: () => onReport(comment),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                      tooltip: 'Denunciar comentário',
                    ),
                  ],
                ),

                Text(
                  comment.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      formatTimeAgo(comment.createdAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),

                    const SizedBox(width: 16),

                    if (!isReply)
                      GestureDetector(
                        onTap: () => onReply(comment),
                        child: const Text(
                          "Responder",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    if (!isReply) const SizedBox(width: 16),

                    InkWell(
                      onTap: () => onLike(comment),
                      borderRadius: BorderRadius.circular(20),
                      child: Row(
                        children: [
                          Icon(
                            isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            size: 20,
                            color: isLiked
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade600,
                          ),
                          if (likeCount > 0) ...[
                            const SizedBox(width: 6),
                            Text(
                              '$likeCount',
                              style: TextStyle(
                                color: isLiked
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey.shade600,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
