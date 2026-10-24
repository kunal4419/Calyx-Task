import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final displayBase = GoogleFonts.archivoBlackTextTheme();
    final bodyBase = GoogleFonts.interTextTheme();

    final textTheme = bodyBase
        .apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        )
        .copyWith(
          displayLarge: displayBase.displayLarge?.copyWith(
            fontSize: 38,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
            height: 1.1,
            color: AppColors.textPrimary,
          ),
          headlineMedium: displayBase.headlineMedium?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.5,
            height: 1.15,
            color: AppColors.textPrimary,
          ),
          titleLarge: displayBase.titleLarge?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.25,
            color: AppColors.textPrimary,
          ),
          titleMedium: bodyBase.titleMedium?.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            height: 1.3,
            color: AppColors.textPrimary,
          ),
          bodyLarge: bodyBase.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.45,
            color: AppColors.textPrimary,
          ),
          bodyMedium: bodyBase.bodyMedium?.copyWith(
            fontSize: 14,
            height: 1.4,
            color: AppColors.textSecondary,
          ),
          labelLarge: bodyBase.labelLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
          labelMedium: bodyBase.labelMedium?.copyWith(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        );

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
      borderSide: const BorderSide(color: AppColors.border),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.cta,
        onPrimary: AppColors.ctaText,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        outline: AppColors.border,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.cta,
          foregroundColor: AppColors.ctaText,
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.pillRadius),
          ),
          textStyle: textTheme.labelLarge?.copyWith(fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.cta, width: 1.5),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
        labelStyle: textTheme.bodyMedium,
        hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textTertiary),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
    );
  }
}
