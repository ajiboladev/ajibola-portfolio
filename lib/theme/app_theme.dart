import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for all brand colors, gradients and text styles.
/// Change [AppColors.brand] and the whole app re-themes itself.
class AppColors {
  static const Color brand = Color(0xFF5253FB);
  static const Color brandLight = Color(0xFF8C8DFF);
  static const Color brandDeep = Color(0xFF34359E);

  static const Color bgDeep = Color(0xFF07070C);
  static const Color bgSurface = Color(0xFF0E0E16);
  static const Color bgSurfaceAlt = Color(0xFF13131F);

  static const Color glassFill = Color(0x14FFFFFF); // white @ 8%
  static const Color glassBorder = Color(0x29FFFFFF); // white @ 16%

  static const Color textPrimary = Color(0xFFF5F5FA);
  static const Color textSecondary = Color(0xFFA5A6C2);
  static const Color textMuted = Color(0xFF6F7090);

  static const Color success = Color(0xFF4ADE80);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [Color(0xFF7C7DFF), brand, Color(0xFF3D3EE0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient textGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), brandLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}

class AppTheme {
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    final textTheme = GoogleFonts.outfitTextTheme(base.textTheme).apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.bgDeep,
      textTheme: textTheme,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.brand,
        secondary: AppColors.brandLight,
        surface: AppColors.bgSurface,
      ),
      splashColor: AppColors.brand.withOpacity(0.1),
      highlightColor: Colors.transparent,
    );
  }

  /// Display font (headings) — Sora gives that modern, geometric, techy feel.
  static TextStyle display(double size,
      {FontWeight weight = FontWeight.w700, Color? color, double? height}) {
    return GoogleFonts.sora(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: -0.5,
    );
  }

  /// Body font — Outfit, clean and readable.
  static TextStyle body(double size,
      {FontWeight weight = FontWeight.w400, Color? color, double? height}) {
    return GoogleFonts.outfit(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.textSecondary,
      height: height,
    );
  }

  /// Monospace-ish accent for tags / labels.
  static TextStyle mono(double size, {Color? color, FontWeight? weight}) {
    return GoogleFonts.jetBrainsMono(
      fontSize: size,
      color: color ?? AppColors.brandLight,
      fontWeight: weight ?? FontWeight.w500,
      letterSpacing: 0.5,
    );
  }
}

/// Simple responsive breakpoints used across the app.
class Breakpoints {
  static const double mobile = 640;
  static const double tablet = 1024;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}
