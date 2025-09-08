import 'package:participa/domain/entities/comment_entity/comment_entity.dart';
import 'package:participa/domain/entities/description_entity/description_entity.dart';

class PautaEntity {
  final int id;
  final String title;
  final String image;
  final String userId;
  final String userName;
  final String userPhotoUrl;
  final DateTime createdAt;
  final List<DescriptionEntity> descriptions;
  final List<CommentEntity> comments;

  const PautaEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.userId,
    required this.userName,
    required this.userPhotoUrl,
    required this.createdAt,
    required this.descriptions,
    required this.comments,
  });
}
