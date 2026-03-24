import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../providers/portfolio_provider.dart';
import 'empty_funds_table.dart';
import 'funds_data_table.dart';

/// Sección completa de la tabla de fondos del Dashboard, incluyendo encabezado y contenido.
///
/// Lee el estado del portafolio internamente; no recibe parámetros de estado ni [WidgetRef].
class FundsTableSection extends ConsumerWidget {
  const FundsTableSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.analytics_rounded,
              color: AppTheme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              context.l10n.dashboardMyFundsTitle,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        if (portfolioState.entries.isEmpty)
          const EmptyFundsTable()
        else
          const FundsDataTable(),
      ],
    );
  }
}
