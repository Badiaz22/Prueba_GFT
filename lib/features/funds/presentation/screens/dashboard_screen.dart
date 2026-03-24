import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/responsive.dart';
import '../providers/portfolio_provider.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/top_cards_row.dart';
import '../widgets/dashboard/funds_table_section.dart';

/// Pantalla principal del panel de control (Dashboard).
///
/// Muestra el saldo actual, las tarjetas de resumen y la tabla
/// de fondos activos del usuario.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioNotifierProvider);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalPadding,
          vertical: 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                SizedBox(height: context.verticalSpacingLg),

                TopCardsRow(
                  balance: portfolioState.balance,
                  onInvest: () => context.go('/funds'),
                ),
                SizedBox(height: context.verticalSpacingLg),

                const FundsTableSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
