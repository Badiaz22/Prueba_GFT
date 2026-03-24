import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/theme/app_theme.dart';

/// Campo de texto para ingresar el monto de suscripción, con indicador visual de error.
class SubscribeAmountField extends StatelessWidget {
  /// Controlador del campo de texto con el monto ingresado.
  final TextEditingController controller;

  /// `true` si el monto actual no pasa la validación, activa el estilo de error.
  final bool hasError;

  /// Callback invocado cada vez que el texto cambia.
  final ValueChanged<String> onChanged;

  const SubscribeAmountField({
    super.key,
    required this.controller,
    required this.hasError,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = hasError
        ? AppTheme.errorLightColor
        : AppTheme.borderLightColor;
    final fillColor = hasError
        ? AppTheme.errorLightColor.withValues(alpha: 0.3)
        : AppTheme.surfaceHoverColor;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        prefixText: 'COP \$ ',
        prefixStyle: const TextStyle(
          fontSize: 14,
          color: AppTheme.textSubtitleColor,
          fontWeight: FontWeight.w500,
        ),
        hintText: '0',
        hintStyle: const TextStyle(color: AppTheme.borderLightColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: hasError ? AppTheme.errorDarkColor : AppTheme.primaryColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}
