// lib/screens/play_game/widgets/scoreboard.dart

import 'package:flutter/material.dart';
import 'package:kids_learn_app/core/spacing.dart';
import '../../../../core/app_strings.dart';
import '../../../../core/themes/app_colors.dart';

class Scoreboard extends StatelessWidget {
  final int score;
  const Scoreboard({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.scoreText,
            style: TextStyle(color: Colors.white),

          ),
          horizontalSpace(10),
          Text(
            '$score',
            style: Theme.of(context)
                .textTheme
                .displaySmall?.copyWith(color: AppColors.pinkColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}