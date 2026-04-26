import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary (Accent)
  static const Color primary = Color(0xFF00D4FF); // Vibrant Teal/Cyan
  static const Color primaryDark = Color(0xFF00A8CC);

  // Secondary
  static const Color secondary = Color(0xFFFF6B6B); // Warm Coral
  static const Color secondaryDark = Color(0xFFFF5252);

  // Tertiary
  static const Color tertiary = Color(0xFF39FF14); // Neon Green

  // Backgrounds / surfaces
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color lightBg = Color(0xFFF5F5F7);
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Text
  static const Color darkText = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color lightText = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF666666);

  // Semantic
  static const Color success = Color(0xFF00FF41);
  static const Color warning = Color(0xFFFFB800);
  static const Color error = Color(0xFFFF3D3D);

  // Neutral
  static const Color neutral = Color(0xFF808080);
}

class AppTheme {
  AppTheme._();

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primary = isDark ? AppColors.primary : AppColors.primary;
    final secondary = isDark ? AppColors.secondaryDark : AppColors.secondary;
    final tertiary = AppColors.tertiary;

    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: brightness,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: isDark ? AppColors.primaryDark : const Color(0xFFB3F1FF),
      onPrimaryContainer: isDark ? Colors.white : AppColors.lightText,
      secondary: secondary,
      onSecondary: Colors.white,
      secondaryContainer: isDark ? const Color(0xFF3A1F1F) : const Color(0xFFFFD6D6),
      onSecondaryContainer: isDark ? Colors.white : AppColors.lightText,
      tertiary: tertiary,
      onTertiary: Colors.black,
      tertiaryContainer: isDark ? const Color(0xFF153B12) : const Color(0xFFC9FFB8),
      onTertiaryContainer: isDark ? Colors.white : Colors.black,
      error: AppColors.error,
      onError: Colors.white,
      errorContainer: isDark ? const Color(0xFF4A1A1A) : const Color(0xFFFFD0D0),
      onErrorContainer: isDark ? Colors.white : AppColors.lightText,
      surface: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      onSurface: isDark ? AppColors.darkText : AppColors.lightText,
      surfaceContainer: isDark ? const Color(0xFF151515) : const Color(0xFFF0F0F6),
      surfaceContainerHighest: isDark ? const Color(0xFF232323) : const Color(0xFFEDEDF2),
      onSurfaceVariant: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
      outline: isDark ? const Color(0xFF3A3A3A) : const Color(0xFFD6D6DE),
      outlineVariant: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE3E3EA),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: isDark ? AppColors.lightSurface : AppColors.darkSurface,
      onInverseSurface: isDark ? AppColors.lightText : AppColors.darkText,
      inversePrimary: isDark ? AppColors.primary : AppColors.primaryDark,
      surfaceTint: primary,
    );

    final scaffoldBg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = scheme.surfaceContainer;
    final outline = scheme.outline;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBg,
      dividerColor: scheme.outlineVariant,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: scheme.primary,
        ),
        titleTextStyle: TextStyle(
          color: scheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? const Color(0xFF202020) : const Color(0xFF1A1A1A),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
        labelStyle: TextStyle(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}

