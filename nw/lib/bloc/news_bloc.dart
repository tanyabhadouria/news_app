import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nw/bloc/news_event.dart';
import 'package:nw/bloc/news_state.dart';
import 'package:nw/const.dart';
import 'package:nw/models/article.dart';

BlocProvider<NewsBloc> newsBlocProvider() {
  return BlocProvider<NewsBloc>(
    create: (context) => NewsBloc(),
  );
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Dio _dio = Dio();

  NewsBloc() : super(NewsLoadingState()) {
    on<FetchNews>((event, emit) async {
      try {
        final response = await _dio.get(
          'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${NEWS_API_KEY}',
        );
        final articlesJson = response.data["articles"] as List;
        final newsArticles = articlesJson
            .map((a) => Article.fromJson(a))
            .toList()
            .where((a) => a.title != "[Removed]")
            .toList();
        // final imageUrls = newsArticles
        //     .map((article) => article.urlToImage)
        //     .toList()
        //     .whereNotNull();

        emit(NewsLoadedState(newsArticles, articleList: []));
      } catch (e) {
        emit(NewsErrorState(e.toString(), errorMessage: "error"));
      }
    });
  }
}
