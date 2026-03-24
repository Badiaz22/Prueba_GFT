import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../../../core/utils/responsive.dart';

/// Encabezado del Dashboard con saludo personalizado e información del usuario.
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final isSmall = context.isMobile;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.dashboardTitle,
          style: TextStyle(
            fontSize: isSmall ? 22 : 30,
            fontWeight: FontWeight.w900,
            color: AppTheme.textPrimaryColor,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.dashboardSubtitle,
          style: TextStyle(
            fontSize: isSmall ? 13 : 15,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
