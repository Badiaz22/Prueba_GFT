import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../domain/entities/fund_entity.dart';
import '../common/operation_result_dialog.dart';
import '../common/operation_result_type.dart';
import '../common/table_column_header.dart';
import '../../providers/portfolio_provider.dart';
import 'cancel_subscription_dialog.dart';
import 'fund_table_row.dart';

/// Tabla de datos que lista los fondos activos del portafolio del usuario.
///
/// Lee el estado del portafolio internamente; no recibe [WidgetRef] como parÃ¡metro.
class FundsDataTable extends ConsumerWidget {
  const FundsDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioState = ref.watch(portfolioNotifierProvider);

    return Container(
      width: double.infinity,
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
                          context.l10n.tableHeaderType,
                          flex: 2,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderAmount,
                          flex: 2,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderAction,
                          flex: 1,
                          alignRight: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                ],

                // Table rows
                ...portfolioState.entries.asMap().entries.map((mapEntry) {
                  final entry = mapEntry.value;
                  final isLast =
                      mapEntry.key == portfolioState.entries.length - 1;

                  return Column(
                    children: [
                      FundTableRow(
                        fund: entry.fund,
                        amount: entry.investedAmount,
                        onCancel: () => _showCancelDialog(
                          context,
                          ref,
                          entry.fund,
                          entry.investedAmount,
                        ),
                      ),
                      if (!isLast)
                        Divider(height: 1, color: Colors.grey.shade100),
                    ],
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(
    BuildContext context,
    WidgetRef ref,
    FundEntity fund,
    int amount,
  ) async {
    final confirmed = await CancelSubscriptionDialog.show(
      context,
      fund: fund,
      amount: amount,
    );

    if (confirmed != true || !context.mounted) return;

    final result = await ref
        .read(portfolioNotifierProvider.notifier)
        .cancelSubscription(fundId: fund.id);

    if (!context.mounted) return;
    await result.fold(
      (failure) => OperationResultDialog.showError(
        context: context,
        fundName: fund.name,
        amount: amount,
        errorMessage: failure.message,
      ),
      (_) => OperationResultDialog.showSuccess(
        context: context,
        type: OperationResultType.cancelSuccess,
        fundName: fund.name,
        amount: amount,
        date: DateTime.now(),
      ),
    );
  }
}
