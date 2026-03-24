import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/entities/fund_entity.dart';
import '../common/surface_card.dart';
import 'subscribe_amount_field.dart';
import 'notification_method_card.dart';

/// Columna del formulario de suscripción con campos, selector de notificación y botones.
class SubscribeFormColumn extends StatelessWidget {
  /// Llave global del formulario para acceder a su estado de validación.
  final GlobalKey<FormState> formKey;

  /// Controlador del campo de texto del monto.
  final TextEditingController amountController;

  /// Método de notificación actualmente seleccionado.
  final NotificationMethodEnum selectedMethod;

  /// Mensaje de error en línea, o `null` si no hay errores activos.
  final String? inlineError;

  /// Fondo al que se está suscribiendo.
  final FundEntity fund;

  /// Callback invocado cuando el usuario cambia el método de notificación.
  final ValueChanged<NotificationMethodEnum> onMethodChanged;

  /// Callback invocado cuando el usuario modifica el campo de monto.
  final ValueChanged<String> onAmountChanged;

  /// Callback invocado cuando el usuario confirma la suscripción.
  final VoidCallback onSubmit;

  /// Callback invocado cuando el usuario cancela la operación.
  final VoidCallback onCancel;

  const SubscribeFormColumn({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.selectedMethod,
    required this.inlineError,
    required this.fund,
    required this.onMethodChanged,
    required this.onAmountChanged,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = inlineError != null;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Investment amount card
        SurfaceCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.payments_outlined,
                    size: 20,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    l10n.subscribeAmountLabel,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                l10n.subscribeAmountInputLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMediumColor,
                ),
              ),
              const SizedBox(height: 6),
              SubscribeAmountField(
                controller: amountController,
                hasError: hasError,
                onChanged: onAmountChanged,
              ),
              if (hasError) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 14,
                      color: AppTheme.errorDarkColor,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        inlineError!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.errorDarkColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              Text(
                l10n.subscribeNotificationMethodLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textMediumColor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: NotificationMethodCard(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      description: l10n.notifEmailDescription,
                      isSelected:
                          selectedMethod == NotificationMethodEnum.email,
                      onTap: () =>
                          onMethodChanged(NotificationMethodEnum.email),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: NotificationMethodCard(
                      icon: Icons.sms_outlined,
                      label: 'SMS',
                      description: l10n.notifSmsDescription,
                      isSelected: selectedMethod == NotificationMethodEnum.sms,
                      onTap: () => onMethodChanged(NotificationMethodEnum.sms),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Disclosure card
        SurfaceCard(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceHoverColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppTheme.textSubtitleColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.subscribeDisclosureTitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      l10n.subscribeDisclosureBody,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSubtitleColor,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Action buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.subscribeConfirmButton,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.textMediumColor,
                side: const BorderSide(color: AppTheme.borderLightColor),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                l10n.subscribeCancelButton,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
