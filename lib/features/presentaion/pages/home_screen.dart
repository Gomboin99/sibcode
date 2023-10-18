import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode/features/presentaion/widgets/app_appbar.dart';
import 'package:sibcode/features/presentaion/widgets/news_list_widget.dart';
import 'package:sibcode/utils/app_icons.dart';

import '../../../utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        icon: AppIcons.user,
        color: AppColors.grey222,
        onTap: () => context.go('/'),
        text: 'Media',
      ),
      body: NewsListWidget(),
    );
  }
}
