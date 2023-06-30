import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.buttonText,
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: color, // Specify the desired border color here
          width: 1.0, // Adjust the border width if needed
        ),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.buttonText.copyWith(
          color: color,
        ),
      ),
    );
  }
}
