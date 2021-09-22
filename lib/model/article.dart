import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final int id;
  final int courseId;
  final String shareUser;
  final String title;
  final int? order;
  final int? visible;

  Article({required this.id, required this.courseId, required this.title, required this.shareUser, this.order, this.visible});
  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}