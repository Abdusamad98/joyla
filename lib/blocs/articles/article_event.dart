import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class GetArticles extends ArticleEvent {
  @override
  List<Object?> get props => [];
}


class GetArticleById extends ArticleEvent {

  GetArticleById({required this.articleId});

  final int articleId;

  @override
  List<Object?> get props => [];
}
