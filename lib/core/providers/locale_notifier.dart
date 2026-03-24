import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_notifier.g.dart';

/// Notifier que gestiona la configuración regional activa de la aplicación.
///
/// El idioma por defecto es español (`es`).  Se puede cambiar en cualquier
/// momento llamando a [setLocale]; la UI se reconstruye automáticamente.
@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  static const _supported = [Locale('es'), Locale('en')];

  /// Locales soportados por la aplicación.
  static List<Locale> get supportedLocales => _supported;

  @override
  Locale build() => const Locale('es');

  /// Cambia el idioma activo.
  void setLocale(Locale locale) {
    assert(
      _supported.contains(locale),
      'Locale $locale is not in supportedLocales',
    );
    state = locale;
  }
}
