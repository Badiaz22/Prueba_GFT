import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../domain/entities/fund_entity.dart';
import '../../../domain/enums/notification_method_enum.dart';
import '../common/operation_result_dialog.dart';
import '../common/operation_result_type.dart';
import '../common/table_column_header.dart';
import '../../providers/portfolio_provider.dart';
import '../../screens/subscribe_screen.dart';
import 'invest_fund_row.dart';

/// Tabla de fondos disponibles con soporte de suscripciÃ³n directa.
///
/// Lee el estado del portafolio internamente; no recibe [WidgetRef] como parÃ¡metro.
class FundsTable extends ConsumerWidget {
  /// Lista de fondos disponibles para invertir.
  final List<FundEntity> funds;

  const FundsTable({super.key, required this.funds});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioNotifierProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Builder(
          builder: (context) {
            final isSmall = MediaQuery.of(context).size.width < 600;
            return Column(
              children: [
                // Table header
                if (!isSmall) ...[
                  Container(
                    color: AppTheme.surfaceHoverColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        TableColumnHeader(
                          context.l10n.tableHeaderFundName,
                          flex: 3,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderCategory,
                          flex: 2,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderMinAmount,
                          flex: 2,
                          alignRight: true,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderStatus,
                          flex: 2,
                          alignCenter: true,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderAction,
                          flex: 2,
                          alignCenter: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                ],

                // Table rows
                ...funds.asMap().entries.map((mapEntry) {
                  final fund = mapEntry.value;
                  final isLast = mapEntry.key == funds.length - 1;
                  final isSubscribed = portfolioState.entries.any(
                    (e) => e.fund.id == fund.id,
                  );

                  return Column(
                    children: [
                      InvestFundRow(
                        fund: fund,
                        isSubscribed: isSubscribed,
                        onSubscribe: () => _showSubscribeDialog(
                          context,
                          ref,
                          fund,
                          portfolioState.balance,
                        ),
                      ),
                      if (!isLast)
                        Divider(height: 1, color: Colors.grey.shade100),
                    ],
                  );
                }),

                // Footer count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceHoverColor.withValues(alpha: 0.5),
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        context.l10n.tableShowingPrefix,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${funds.length}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        context.l10n.tableFundsSuffix,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showSubscribeDialog(
    BuildContext context,
    WidgetRef ref,
    FundEntity fund,
    int balance,
  ) async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder: (ctx, anim, sec) =>
            SubscribeScreen(fund: fund, currentBalance: balance),
        transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOut));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );

    if (result == null || !context.mounted) return;

    final subscribedAmount = result['amount'] as int;
    final notifMethod = result['notificationMethod'] as NotificationMethodEnum;

    final subscribeResult = await ref
        .read(portfolioNotifierProvider.notifier)
        .subscribe(
          fund: fund,
          amount: subscribedAmount,
          notificationMethod: notifMethod,
        );

    if (!context.mounted) return;
    await subscribeResult.fold(
      (failure) => OperationResultDialog.showError(
        context: context,
        fundName: fund.name,
        amount: subscribedAmount,
        errorMessage: failure.message,
      ),
      (_) => OperationResultDialog.showSuccess(
        context: context,
        type: OperationResultType.subscribeSuccess,
        fundName: fund.name,
        amount: subscribedAmount,
        date: DateTime.now(),
        notificationMethod: notifMethod,
      ),
    );
  }
}
