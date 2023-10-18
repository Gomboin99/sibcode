import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/news_entitiy.dart';
import '../cubit/news_cubit/news_cubit.dart';
import '../cubit/news_cubit/news_state.dart';
import 'news_card_widget.dart';

class NewsListWidget extends StatelessWidget {
  NewsListWidget({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListCubit, NewsState>(
      builder: (context, state) {
        List<NewsEntity> news = [];
        if (state is NewsLoading) {
          return _loadingIndicator();
        } else if (state is NewsLoaded) {
          news = state.newsList;
        } else if (state is NewsError) {
          return Text(
            state.message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.only(
            top: 21,
            left: 16,
            right: 19,
            bottom: 21,
          ),
          controller: scrollController,
          itemBuilder: (context, index) {
            NewsEntity? newsWithIdTwo;
            if (news[index].id == '2') {
              newsWithIdTwo = news[index];
            }

            return NewsCardWidget(news: news[index], newsForDetail: secondNews(news),);
          },
          itemCount: news.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 21,
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  NewsEntity? secondNews (List<NewsEntity> news) {
    for (final oneNews in news) {
      if (oneNews.id == '2') {
        return oneNews;
      }
    }
    return null;
  }

}
