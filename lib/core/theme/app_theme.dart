import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

/// Tema Material 3 dengan konsep Sage Green & Beige.
class AppTheme {
  AppTheme._();

  // Warna utama aplikasi BeritaKita.
  static const Color _seed = Color(0xFF355E4B);

  // Palet warna Sage Green & Beige.
  static const Color _sageGreen = Color(0xFF355E4B);
  static const Color _softGreen = Color(0xFF78977A);
  static const Color _warmBeige = Color(0xFFF3EFE4);
  static const Color _white = Color(0xFFFFFFFF);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final generatedScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );

    // Warna khusus untuk Light Mode.
    final scheme = brightness == Brightness.light
        ? generatedScheme.copyWith(
            primary: _sageGreen,
            onPrimary: _white,
            secondary: _softGreen,
            onSecondary: _white,
            surface: _warmBeige,
            onSurface: const Color(0xFF25352B),
            surfaceContainer: const Color(0xFFEAE5D9),
            primaryContainer: const Color(0xFFDCE8DC),
            onPrimaryContainer: const Color(0xFF253F30),
            outlineVariant: const Color(0xFFD4D8CE),
          )
        : generatedScheme;

    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    final text = base.textTheme;

    return base.copyWith(
      scaffoldBackgroundColor: scheme.surface,

      textTheme: text.copyWith(
        headlineMedium: text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineSmall: text.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleLarge: text.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        titleMedium: text.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        bodyLarge: text.bodyLarge?.copyWith(height: 1.6),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),

      chipTheme: const ChipThemeData(shape: StadiumBorder()),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.6),
        thickness: 1,
        space: 1,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: scheme.secondaryContainer,
      ),

      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),

      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
