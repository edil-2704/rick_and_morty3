import 'package:flutter/material.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: AppColors.mainWhite,
    primary: AppColors.mainBlack,
    secondary: Colors.white,
    tertiary: AppColors.mainBlack,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF2F2F2),
    selectedLabelStyle: TextStyle(color: AppColors.mainGreen),
    selectedIconTheme: IconThemeData(color: AppColors.mainGreen),
    selectedItemColor: AppColors.mainGreen,
  ),
  dialogBackgroundColor: Colors.white,
  scaffoldBackgroundColor: AppColors.mainBlack,
  iconTheme: const IconThemeData(color: AppColors.mainBlack),
  dialogTheme: const DialogTheme(backgroundColor: AppColors.mainBlack),
  cardTheme: const CardTheme(color: AppColors.mainWhite),
);
