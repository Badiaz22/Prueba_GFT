import 'package:flutter/material.dart';

/// Extensión sobre [BuildContext] para simplificar el acceso a los
/// breakpoints responsivos de la aplicación.
///
/// Uso:
/// ```dart
/// if (context.isMobile) { ... }
/// EdgeInsets.symmetric(horizontal: context.isMobile ? 16 : 32);
/// ```
extension ResponsiveX on BuildContext {
  /// Ancho actual de la pantalla.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// `true` cuando el ancho es menor a 600 px (teléfono).
  bool get isMobile => screenWidth < 600;

  /// `true` cuando el ancho es mayor o igual a 720 px (tableta / pantalla ancha).
  bool get isWide => screenWidth >= 720;

  /// `true` cuando el ancho es mayor a 800 px (escritorio con barra lateral).
  bool get isDesktop => screenWidth > 800;

  /// Padding horizontal adaptado al tamaño de pantalla (16 en móvil, 32 en desktop).
  double get horizontalPadding => isMobile ? 16.0 : 32.0;

  /// Espaciado vertical grande adaptado (24 en móvil, 40 en desktop).
  double get verticalSpacingLg => isMobile ? 24.0 : 40.0;

  /// Espaciado vertical mediano adaptado (20 en móvil, 32 en desktop).
  double get verticalSpacingMd => isMobile ? 20.0 : 32.0;
}
