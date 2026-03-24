import 'package:flutter/material.dart';
import 'help_card.dart';
import 'dashboard_balance_card.dart';

/// Fila superior del Dashboard con la tarjeta de saldo y el acceso rápido a inversiones.
class TopCardsRow extends StatelessWidget {
  /// Saldo disponible en COP a mostrar en la tarjeta.
  final int balance;

  /// Callback invocado cuando el usuario pulsa el botón de invertir.
  final VoidCallback onInvest;

  const TopCardsRow({super.key, required this.balance, required this.onInvest});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    if (isWide) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: DashboardBalanceCard(balance: balance, onInvest: onInvest),
            ),
            const SizedBox(width: 24),
            Expanded(child: HelpCard()),
          ],
        ),
      );
    }

    return Column(
      children: [
        DashboardBalanceCard(balance: balance, onInvest: onInvest),
        const SizedBox(height: 16),
        HelpCard(),
      ],
    );
  }
}
