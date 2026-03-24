import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Definición central del tema visual de BTG Capital.
///
/// Provee colores de marca, tema claro y el getter [theme] para
/// acceder al [ThemeData] configurado a nivel de aplicación.
class AppTheme {
  AppTheme._();

  /// Color primario de la marca BTG Capital (azul oscuro corporativo).
  static const primaryColor = Color(0xFF002D61);

  // ── Colores de texto ──────────────────────────────────────────────────────
  /// Color de texto primario (casi negro azulado) para títulos y cuerpo.
  static const textPrimaryColor = Color(0xFF0F172A);

  /// Color de encabezados oscuros en barra de navegación y AppBar.
  static const textDarkColor = Color(0xFF1E293B);

  /// Énfasis medio para valores numéricos y etiquetas secundarias.
  static const textMediumColor = Color(0xFF334155);

  /// Texto secundario para labels de formulario e iconos auxiliares.
  static const textSecondaryColor = Color(0xFF5E748D);

  /// Texto de subtítulo y descripciones de pantalla.
  static const textSubtitleColor = Color(0xFF64748B);

  /// Texto silenciado: marcas de tiempo, hints y placeholders.
  static const textMutedColor = Color(0xFF94A3B8);

  // ── Colores de fondo y superficie ─────────────────────────────────────────
  /// Color de fondo general de las pantallas (también accesible por scaffold).
  static const backgroundColor = Color(0xFFF5F7F8);

  /// Color de fondo interno de tarjetas y diálogos.
  static const surfaceColor = Colors.white;

  /// Fondo de fila en estado hover.
  static const surfaceHoverColor = Color(0xFFF8FAFC);

  /// Borde sutil entre secciones.
  static const borderLightColor = Color(0xFFE2E8F0);

  // ── Colores semánticos ────────────────────────────────────────────────────
  /// Fondo suave para badges y estados de éxito/suscrito.
  static const successLightColor = Color(0xFFD1FAE5);

  /// Texto y relleno oscuro para estados de éxito.
  static const successDarkColor = Color(0xFF047857);

  /// Color de éxito utilizado en confirmaciones y estados positivos.
  static const successColor = Color(0xFF2E7D32);

  /// Fondo suave para badges de error / cancelación.
  static const errorLightColor = Color(0xFFFEE2E2);

  /// Texto oscuro para estados de error.
  static const errorDarkColor = Color(0xFFB91C1C);

  /// Color de error estándar para mensajes y bordes de validación.
  static const errorColor = Color(0xFFD32F2F);

  // ── Colores de categoría de fondos ────────────────────────────────────────
  /// Fondo del badge de fondos FPV.
  static const fpvBadgeBgColor = Color(0xFFDBEAFE);

  /// Color de texto del badge de fondos FPV.
  static const fpvBadgeFgColor = Color(0xFF1D4ED8);

  /// Fondo del badge de fondos FIC.
  static const ficBadgeBgColor = Color(0xFFD1FAE5);

  /// Color de texto del badge de fondos FIC.
  static const ficBadgeFgColor = Color(0xFF047857);

  // ── Privados para ThemeData ───────────────────────────────────────────────

  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: primaryColor,
      surface: surfaceColor,
      error: errorColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceColor,
      foregroundColor: textDarkColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: textDarkColor,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      color: surfaceColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: textMutedColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  /// Getter público que expone el tema claro configurado para la aplicación.
  static ThemeData get lightTheme => _lightTheme;
}
