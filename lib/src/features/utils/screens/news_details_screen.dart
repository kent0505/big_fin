import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/news.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/appbar.dart';
import '../../language/bloc/language_bloc.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.news});

  final News news;

  static const routePath = '/NewsDetailsScreen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final locale = context.watch<LanguageBloc>().state.languageCode;

    return Scaffold(
      appBar: Appbar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            locale == 'en'
                ? news.title1
                : locale == 'ru'
                    ? news.title2
                    : locale == 'es'
                        ? news.title3
                        : news.title4,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 24,
              fontFamily: AppFonts.bold,
            ),
          ),
          SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(news.asset),
          ),
          SizedBox(height: 10),
          Text(
            dateToString(news.date),
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 12,
              fontFamily: AppFonts.medium,
            ),
          ),
          SizedBox(height: 20),
          Text(
            locale == 'en'
                ? news.body1
                : locale == 'ru'
                    ? news.body2
                    : locale == 'es'
                        ? news.body3
                        : news.body4,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16,
              fontFamily: AppFonts.medium,
            ),
          ),
        ],
      ),
    );
  }
}
