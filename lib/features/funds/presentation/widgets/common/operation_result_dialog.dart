import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../domain/enums/notification_method_enum.dart';
import 'operation_result_action_buttons.dart';
import 'operation_result_details_box.dart';
import 'operation_result_icon.dart';
import 'operation_result_type.dart';

/// Diálogo modal que informa al usuario el resultado de una operación.
///
/// Muestra un ícono de éxito o error, detalles de la transacción
/// y botones de acción para continuar.
class OperationResultDialog extends StatelessWidget {
  /// Tipo de resultado: suscripción exitosa, cancelación exitosa o error.
  final OperationResultType type;

  /// Nombre del fondo involucrado en la operación.
  final String fundName;

  /// Monto de la operación en COP.
  final int amount;

  /// Fecha y hora en que se realizó la operación.
  final DateTime date;

  /// Referencia única de la transacción, disponible en operaciones exitosas.
  final String? transactionRef;

  /// Método de notificación elegido por el usuario (email o SMS).
  final NotificationMethodEnum? notificationMethod;

  /// Mensaje descriptivo del error, presente solo cuando [type] es `error`.
  final String? errorMessage;

  const OperationResultDialog({
    super.key,
    required this.type,
    required this.fundName,
    required this.amount,
    required this.date,
    this.transactionRef,
    this.notificationMethod,
    this.errorMessage,
  });

  static Future<void> showSuccess({
    required BuildContext context,
    required OperationResultType type,
    required String fundName,
    required int amount,
    required DateTime date,
    String? transactionRef,
    NotificationMethodEnum? notificationMethod,
  }) {
    return _show(
      context,
      OperationResultDialog(
        type: type,
        fundName: fundName,
        amount: amount,
        date: date,
        transactionRef: transactionRef,
        notificationMethod: notificationMethod,
      ),
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String fundName,
    required int amount,
    required String errorMessage,
  }) {
    return _show(
      context,
      OperationResultDialog(
        type: OperationResultType.error,
        fundName: fundName,
        amount: amount,
        date: DateTime.now(),
        errorMessage: errorMessage,
      ),
    );
  }

  static Future<void> _show(
    BuildContext context,
    OperationResultDialog dialog,
  ) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context).operationResultCloseButton,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (ctx, _, _) => dialog,
      transitionBuilder: (ctx, animation, _, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.90, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  bool get _isSuccess => type != OperationResultType.error;
  bool get _isSubscribe => type == OperationResultType.subscribeSuccess;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dateStr = DateFormat("dd MMM, yyyy '–' HH:mm", 'es').format(date);
    final ref =
        transactionRef ??
        '#BTG-${date.millisecondsSinceEpoch.toString().substring(7)}-${_isSubscribe ? 'S' : 'C'}';

    final rows = <(String, String, bool)>[
      (l10n.operationResultFundLabel, fundName, false),
      (
        _isSubscribe
            ? l10n.operationResultAmountSubscribedLabel
            : l10n.operationResultAmountReturnedLabel,
        CurrencyFormatter.format(amount),
        false,
      ),
      (l10n.operationResultDateLabel, dateStr, false),
      if (!_isSuccess && errorMessage != null)
        (l10n.operationResultErrorLabel, errorMessage!, false),
      if (_isSuccess) (l10n.operationResultReferenceLabel, ref, true),
      if (notificationMethod != null)
        (
          l10n.operationResultNotificationLabel,
          notificationMethod == NotificationMethodEnum.email
              ? l10n.transactionNotifEmail
              : l10n.transactionNotifSms,
          false,
        ),
    ];

    return Stack(
      children: [
        // Blurred backdrop
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: Colors.black.withValues(alpha: 0.55)),
          ),
        ),
        // Dialog
        Center(
          child: Material(
            color: Colors.transparent,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: Container(
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 40,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 36, 32, 32),
                      child: Column(
                        children: [
                          OperationResultIcon(isSuccess: _isSuccess),
                          const SizedBox(height: 24),

                          Text(
                            _title(l10n),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Text(
                            _description(l10n),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 28),

                          OperationResultDetailsBox(rows: rows),
                          const SizedBox(height: 28),

                          OperationResultActionButtons(isSuccess: _isSuccess),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _title(AppLocalizations l10n) => switch (type) {
    OperationResultType.subscribeSuccess => l10n.operationResultSubscribeTitle,
    OperationResultType.cancelSuccess => l10n.operationResultCancelTitle,
    OperationResultType.error => l10n.operationResultErrorTitle,
  };

  String _description(AppLocalizations l10n) => switch (type) {
    OperationResultType.subscribeSuccess =>
      l10n.operationResultSubscribeDescription,
    OperationResultType.cancelSuccess => l10n.operationResultCancelDescription,
    OperationResultType.error =>
      errorMessage ?? l10n.operationResultErrorDescription,
  };
}
