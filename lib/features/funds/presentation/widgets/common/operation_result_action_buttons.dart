import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Botones de acción mostrados al final del diálogo de resultado de operación.
///
/// Retorna texto diferente según si la operación fue exitosa o fallida.
class OperationResultActionButtons extends StatelessWidget {
  /// `true` si la operación fue exitosa; `false` si hubo un error.
  final bool isSuccess;

  const OperationResultActionButtons({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => Navigator.of(context).pop(),
        style: FilledButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Text(
          context.l10n.operationResultCloseButton,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
