import 'package:flutter/material.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../common/table_column_header.dart';
import 'transaction_row.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Tabla que muestra el historial completo de transacciones del usuario.
class TransactionsTable extends StatelessWidget {
  /// Lista de transacciones a renderizar en la tabla.
  final List<TransactionEntity> transactions;

  const TransactionsTable({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
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
                        TableColumnHeader(context.l10n.tableHeaderId, flex: 2),
                        TableColumnHeader(
                          context.l10n.tableHeaderFund,
                          flex: 3,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderType,
                          flex: 2,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderAmount,
                          flex: 2,
                          alignRight: true,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderNotification,
                          flex: 2,
                          alignCenter: true,
                        ),
                        TableColumnHeader(
                          context.l10n.tableHeaderDate,
                          flex: 2,
                          alignRight: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey.shade200),
                ],

                // Rows
                ...transactions.asMap().entries.map((mapEntry) {
                  final tx = mapEntry.value;
                  final isLast = mapEntry.key == transactions.length - 1;

                  return Column(
                    children: [
                      TransactionRow(transaction: tx),
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
                        '${transactions.length}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        context.l10n.tableTransactionsSuffix,
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
}
