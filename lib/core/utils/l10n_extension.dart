import 'package:flutter/widgets.dart';
import 'package:btg_capital/l10n/app_localizations.dart';

/// Acceso rápido a las cadenas localizadas desde cualquier [BuildContext].
///
/// Uso:
/// ```dart
/// Text(context.l10n.fundsTitle)
/// ```
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
