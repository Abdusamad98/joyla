import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyla/blocs/articles/article_bloc.dart';
import 'package:joyla/blocs/articles/article_state.dart';
import 'package:joyla/data/models/articles/article_model.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Articles"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(
        builder: (context, state) {
          if (state is ArticleLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ArticleErrorState) {
            return Center(child: Text(state.errorText));
          }

          if (state is ArticleSuccessState) {
            return ListView(
              children: [
                ...List.generate(state.articles.length, (index) {
                  ArticleModel articleModel = state.articles[index];
                  return ListTile(
                    title: Text(
                      articleModel.title,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                })
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
