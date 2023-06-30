import 'package:al_hidayah/styles/colors.dart';
import 'package:al_hidayah/styles/text_styles.dart';
import 'package:flutter/material.dart';

AppBar appBar({required String title}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white),
    backgroundColor: AppColors.primary,
    title: Text(
      title,
      style: AppTextStyles.title.copyWith(color: Colors.white),
    ),
  );
}
