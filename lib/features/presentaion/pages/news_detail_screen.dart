import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../domain/entities/news_entitiy.dart';
import '../widgets/app_appbar.dart';
import '../widgets/app_text.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({required this.newsForDetail, super.key});

  final NewsEntity? newsForDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppAppBar(
        icon: AppIcons.backLeftIcon,
        color: AppColors.grey222,
        onTap: () => context.go('/home'),
        text: newsForDetail?.name ?? '',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 21,
            ),
            AppText(
              text: parsingDate(),
              size: 14,
              color: AppColors.grey135,
            ),
            const SizedBox(
              height: 6,
            ),
            Image.network(
              newsForDetail?.image ?? '',
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
              text: newsForDetail?.name ?? '',
              size: 14,
              align: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            AppText(
              text: newsForDetail?.description ?? '',
              size: 14,
              align: TextAlign.start,
            ),
          ],
        ),
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
    if (today == newsForDetail?.date) {
      return 'Сегодня';
    } else if (yesterday == newsForDetail?.date) {
      return 'Вчера';
    } else if (tomorrow == newsForDetail?.date) {
      return 'Завтра';
    } else {
      return DateFormat('dd MMMM', 'ru_RU')
          .format(dateFormat.parse(
            newsForDetail?.date ?? DateTime.now().toString(),
          ))
          .toString();
    }
  }
}
