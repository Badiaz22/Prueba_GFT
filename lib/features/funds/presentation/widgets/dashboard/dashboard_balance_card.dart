import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../common/action_button.dart';

/// Tarjeta que muestra el saldo disponible del usuario con un botón para invertir.
class DashboardBalanceCard extends StatelessWidget {
  /// Saldo disponible actual en COP.
  final int balance;

  /// Callback invocado cuando el usuario pulsa el botón de invertir.
  final VoidCallback onInvest;

  const DashboardBalanceCard({
    super.key,
    required this.balance,
    required this.onInvest,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isSmall = width < 600;
    return Container(
      padding: EdgeInsets.all(isSmall ? 20 : 32),
      width: double.infinity,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.dashboardTotalBalanceLabel,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyFormatter.format(balance),
            style: TextStyle(
              fontSize: isSmall ? 26 : 36,
              fontWeight: FontWeight.w900,
              color: AppTheme.primaryColor,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              ActionButton(
                icon: Icons.add_circle_rounded,
                label: context.l10n.dashboardInvestButton,
                isPrimary: true,
                onTap: onInvest,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
