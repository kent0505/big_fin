import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/constants.dart';
import '../../../core/config/my_colors.dart';
import '../../../core/models/news.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/button.dart';
import '../../language/bloc/language_bloc.dart';
import '../screens/news_details_screen.dart';

class NewsTab extends StatelessWidget {
  const NewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            newsList.length,
            (index) {
              return _NewsCard(
                news: newsList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;
    final l = AppLocalizations.of(context)!;
    final locale = context.watch<LanguageBloc>().state.languageCode;

    return Container(
      width: MediaQuery.sizeOf(context).width / 2 - 20,
      height: 290,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.tertiaryOne,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Button(
        onPressed: () {
          context.push(NewsDetailsScreen.routePath, extra: news);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                news.asset,
                width: double.infinity,
                height: 144,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox();
                },
                frameBuilder: frameBuilder,
              ),
            ),
            SizedBox(height: 8),
            Text(
              locale == 'en'
                  ? news.title1
                  : locale == 'ru'
                      ? news.title2
                      : locale == 'es'
                          ? news.title3
                          : news.title4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16,
                fontFamily: AppFonts.bold,
                height: 1.5,
              ),
            ),
            SizedBox(height: 8),
            Text(
              locale == 'en'
                  ? news.body1
                  : locale == 'ru'
                      ? news.body2
                      : locale == 'es'
                          ? news.body3
                          : news.body4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 12,
                fontFamily: AppFonts.medium,
              ),
            ),
            Spacer(),
            Text(
              '${l.lastUpdt} ${dateToString(news.date)}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 8,
                fontFamily: AppFonts.medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
