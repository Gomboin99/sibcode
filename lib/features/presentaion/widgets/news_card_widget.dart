

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sibcode/features/domain/entities/news_entitiy.dart';
import 'package:sibcode/features/presentaion/widgets/app_text.dart';

import '../../../utils/app_colors.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({required this.news, required this.newsForDetail, super.key});

  final NewsEntity news;
  final NewsEntity? newsForDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          'detail',
          extra: newsForDetail,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: parsingDate(),
            size: 14,
            color: AppColors.grey135,
          ),
          const SizedBox(
            height: 6,
          ),
          Image.network(
            news.image,
            errorBuilder: (_, __, ___) => Container(
              width: 340,
              height: 145,
              color: AppColors.grey196,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          AppText(
            text: news.name,
            size: 14,
            align: TextAlign.start,
          ),
        ],
      ),
    );
  }

  String parsingDate() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    final today = dateFormat.format(DateTime.now());
    final yesterday = dateFormat.format(
      DateTime.now().add(
        const Duration(days: -1),
      ),
    );
    final tomorrow = dateFormat.format(
      DateTime.now().add(
        const Duration(days: 1),
      ),
    );
    if (today == news.date) {
      return 'Сегодня';
    } else if (yesterday == news.date) {
      return 'Вчера';
    } else if (tomorrow == news.date) {
      return 'Завтра';
    } else {
      return DateFormat('dd MMMM', 'ru_RU')
          .format(dateFormat.parse(news.date))
          .toString();
    }
  }
}
