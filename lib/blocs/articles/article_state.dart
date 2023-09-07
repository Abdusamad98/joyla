import 'package:equatable/equatable.dart';
import 'package:network_side/models/articles/article_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object?> get props => [];
}

class ArticleSuccessState extends ArticleState {
  ArticleSuccessState({required this.articles});

  final List<ArticleModel> articles;

  @override
  List<Object?> get props => [articles];
}

class ArticleErrorState extends ArticleState {
  ArticleErrorState({required this.errorText});

  final String errorText;

  @override
  List<Object?> get props => [errorText];
}
