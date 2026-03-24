import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_capital/l10n/app_localizations.dart';
import '../core/providers/locale_notifier.dart';
import '../core/theme/app_theme.dart';
import 'router.dart';

/// Widget raíz de la aplicación BTG Capital.
///
/// Configura el tema visual, las delegaciones de localización, el locale
/// activo desde [LocaleNotifier] y el router de navegación declarativo.
class BtgCapitalApp extends ConsumerWidget {
  const BtgCapitalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeNotifierProvider);
    return MaterialApp.router(
      title: 'BTG Capital',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      locale: locale,
      supportedLocales: LocaleNotifier.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
