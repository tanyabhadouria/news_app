import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nw/bloc/news_bloc.dart';
import 'package:nw/bloc/news_event.dart';
import 'package:nw/bloc/news_state.dart';
import 'package:nw/const.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(FetchNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            final articles = state.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return ListTile(
                  onTap: () {
                    _launchUrl(
                      Uri.parse(article.url ?? ""),
                    );
                  },
                  leading: Image.network(
                    article.urlToImage ?? PLACEHOLDER_IMAGE_LINK,
                    height: 250,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    article.title ?? "",
                  ),
                  subtitle: Text(
                    article.publishedAt ?? "",
                  ),
                );
              },
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
