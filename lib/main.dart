import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/app.dart';

/// Punto de entrada principal de la aplicación BTG Capital.
///
/// Inicializa el formateo de fechas en español y arranca el árbol de widgets
/// envuelto en [ProviderScope] para habilitar Riverpod en toda la app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Captura errores de widgets y del framework Flutter.
  FlutterError.onError = FlutterError.presentError;

  // Captura errores asincrónicos no manejados (Zone / PlatformDispatcher).
  PlatformDispatcher.instance.onError = (error, stack) {
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stack),
    );
    return true;
  };

  await initializeDateFormatting('es');

  runApp(const ProviderScope(child: BtgCapitalApp()));
}
