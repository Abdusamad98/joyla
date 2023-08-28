import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/blocs/articles/article_event.dart';
import 'package:joyla/blocs/articles/article_state.dart';
import 'package:joyla/data/models/articles/article_model.dart';
import 'package:joyla/data/models/universal_data.dart';
import 'package:joyla/data/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc({required this.articleRepository})
      : super(ArticleInitialState()) {
    on<GetArticles>(_getArticles);
    // on<GetArticleById>(_getArticleById);
  }

  final ArticleRepository articleRepository;

  Future<void> _getArticles(
    GetArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoadingState());
    UniversalData response = await articleRepository.getArticles();
    if (response.error.isEmpty) {
      emit(ArticleSuccessState(articles: response.data as List<ArticleModel>));
    } else {
      emit(ArticleErrorState(errorText: response.error));
    }
  }
//
// Future<void> _getArticleById(
//   GetArticleById event,
//   Emitter<ArticleState> emit,
// ) async {
//   emit(ArticleLoadingState());
//   UniversalData response = await articleRepository.getArticleById(articleId:event.articleId);
//   if (response.error.isEmpty) {
//     emit(ArticleSuccessState(articles: response.data as List<ArticleModel>));
//   } else {
//     emit(ArticleErrorState(errorText: response.error));
//   }
// }
}
