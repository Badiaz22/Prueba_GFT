import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/locale_notifier.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/l10n_extension.dart';

/// Botón compacto para alternar el idioma entre Español e Inglés.
///
/// Muestra la bandera y el código ISO del idioma activo.
/// Al presionar despliega un [PopupMenuButton] con las opciones disponibles.
class LanguageSwitcher extends ConsumerWidget {
  const LanguageSwitcher({super.key});

  static const _languages = [
    (locale: 'es', flag: '🇨🇴', code: 'ES'),
    (locale: 'en', flag: '🇺🇸', code: 'EN'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeNotifierProvider);
    final current = _languages.firstWhere(
      (l) => l.locale == currentLocale.languageCode,
      orElse: () => _languages.first,
    );

    return PopupMenuButton<String>(
      tooltip: context.l10n.languageSwitcherLabel,
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) => _languages
          .map(
            (lang) => PopupMenuItem<String>(
              value: lang.locale,
              child: Row(
                children: [
                  Text(lang.flag, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 10),
                  Text(
                    lang.locale == 'es'
                        ? context.l10n.languageSpanish
                        : context.l10n.languageEnglish,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: lang.locale == currentLocale.languageCode
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: lang.locale == currentLocale.languageCode
                          ? AppTheme.primaryColor
                          : AppTheme.textPrimaryColor,
                    ),
                  ),
                  if (lang.locale == currentLocale.languageCode) ...[
                    const Spacer(),
                    const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ],
                ],
              ),
              onTap: () => ref
                  .read(localeNotifierProvider.notifier)
                  .setLocale(Locale(lang.locale)),
            ),
          )
          .toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.borderLightColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(current.flag, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(
              current.code,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.arrow_drop_down_rounded,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
