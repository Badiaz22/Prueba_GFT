import 'package:btg_capital/features/funds/domain/entities/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Fila que representa una transacción individual en el historial.
class TransactionRow extends StatefulWidget {
  /// Entidad de transacción que contiene todos los datos a mostrar.
  final TransactionEntity transaction;

  const TransactionRow({super.key, required this.transaction});

  @override
  State<TransactionRow> createState() => _TransactionRowState();
}

/// Estado interno de [TransactionRow] con animación de aparición suave.
class _TransactionRowState extends State<TransactionRow> {
  bool _isHovered = false;
  static final _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  @override
  Widget build(BuildContext context) {
    final tx = widget.transaction;
    final isSubscription = tx.type == TransactionTypeEnum.subscription;
    final isSmall = MediaQuery.of(context).size.width < 600;

    final typeBg = isSubscription
        ? AppTheme.successLightColor
        : AppTheme.errorLightColor;
    final typeColor = isSubscription
        ? AppTheme.successDarkColor
        : AppTheme.errorDarkColor;
    final typeLabel = isSubscription
        ? context.l10n.transactionSubscriptionLabel
        : context.l10n.transactionCancellationLabel;
    final amountColor = isSubscription
        ? AppTheme.successDarkColor
        : AppTheme.errorDarkColor;
    final amountPrefix = isSubscription ? '-' : '+';

    final notifLabel = tx.notificationMethod == NotificationMethodEnum.email
        ? context.l10n.transactionNotifEmail
        : tx.notificationMethod == NotificationMethodEnum.sms
        ? context.l10n.transactionNotifSms
        : context.l10n.transactionNotifNone;

    final typeBadge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: typeBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        typeLabel,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: typeColor,
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: _isHovered ? AppTheme.surfaceHoverColor : Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 16 : 24,
          vertical: isSmall ? 12 : 20,
        ),
        child: isSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      typeBadge,
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          tx.fundName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF0F172A),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        '$amountPrefix ${CurrencyFormatter.format(tx.amount)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: amountColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _dateFormat.format(tx.date),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMutedColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${context.l10n.transactionNotifPrefix}$notifLabel',
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textMutedColor,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      tx.id.length > 12
                          ? '${tx.id.substring(0, 12)}...'
                          : tx.id,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      tx.fundName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppTheme.textPrimaryColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: typeBadge,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      '$amountPrefix ${CurrencyFormatter.format(tx.amount)}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: amountColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      notifLabel,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _dateFormat.format(tx.date),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
