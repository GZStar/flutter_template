import 'package:flutter/material.dart';

import '../values/dimens.dart';
import 'app_colors.dart';

class TextStyles {
  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: AppColors.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: AppColors.textDark,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: AppColors.textGray,
      fontWeight: FontWeight.normal);

  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: AppColors.textGrayDark,
      fontWeight: FontWeight.normal);

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.textGray,
  );

  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.textGrayDark,
  );

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_sp14, color: AppColors.dark_unselected_item_color);

  static const TextStyle appBarTitleText = TextStyle(
    fontSize: Dimens.font_sp18,
    color: Colors.white,
  );

  static const TextStyle appBarTitleTextDark = TextStyle(
    fontSize: Dimens.font_sp18,
    color: AppColors.textDark,
  );
}
