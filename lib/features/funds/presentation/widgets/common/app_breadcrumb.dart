import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Indicador de ruta de navegación (breadcrumb) que muestra `Home > [currentPage]`.
class AppBreadcrumb extends StatelessWidget {
  /// Nombre de la página actual mostrada como último elemento del breadcrumb.
  final String currentPage;

  const AppBreadcrumb({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.l10n.breadcrumbHome,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppTheme.textSecondaryColor,
          ),
        ),
        Text(
          currentPage,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}
