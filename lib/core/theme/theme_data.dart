import 'package:flutter/material.dart';
import 'app_colors.dart';

final themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.backgroundColor),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.backgroundColor,
    titleTextStyle: TextStyle(
      color: AppColors.textColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
  ),
);
