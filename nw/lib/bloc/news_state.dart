import 'package:equatable/equatable.dart';
import 'package:nw/models/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> articles;

  const NewsLoadedState(this.articles, {required List<Article> articleList});

  @override
  List<Object> get props => [articles];
}

class NewsErrorState extends NewsState {
  final String message;

  const NewsErrorState(this.message, {required Object errorMessage});

  @override
  List<Object> get props => [message];
}
