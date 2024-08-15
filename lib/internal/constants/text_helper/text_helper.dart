import 'package:flutter/material.dart';
import 'package:rick_and_morty/internal/constants/theme_helper/app_colors.dart';

abstract class TextHelper {
  static Text charDescription = const Text(
    'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери. ',
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  );

  static TextStyle mainChar = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static TextStyle mainCharInfo = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w400,
  );
  static TextStyle mainBold20 = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.bold,
  );
  static TextStyle totalChar = const TextStyle(
    color: AppColors.mainGrey,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static TextStyle mainCharStatus = const TextStyle(
    color: AppColors.mainGreen,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle mainCharGender = const TextStyle(
    color: AppColors.mainGrey,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle charGenderText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static TextStyle charSexText = const TextStyle(
    color: AppColors.mainGrey,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
