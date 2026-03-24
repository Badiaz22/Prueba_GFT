import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:btg_capital/l10n/app_localizations.dart';

/// Pumps [widget] inside a fully localised [ProviderScope].
///
/// Use [overrides] to inject mock providers (e.g. replace the real repository
/// with a fake). The locale defaults to Spanish to match the project's primary
/// language; pass a different [locale] when testing English strings.
extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
    Locale locale = const Locale('es'),
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: widget,
        ),
      ),
    );
  }
}
