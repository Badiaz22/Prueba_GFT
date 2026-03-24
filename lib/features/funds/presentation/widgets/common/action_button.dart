import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

/// Botón de acción reutilizable con ícono, etiqueta y estilo primario/secundario.
class ActionButton extends StatelessWidget {
  /// Ícono que se muestra a la izquierda de la etiqueta.
  final IconData icon;

  /// Texto de la etiqueta del botón.
  final String label;

  /// Si es `true` usa el color primario; en caso contrario, el estilo secundario.
  final bool isPrimary;

  /// Callback que se invoca cuando el usuario toca el botón.
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.isPrimary = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary ? AppTheme.primaryColor : const Color(0xFFF1F5F9),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isPrimary ? Colors.white : const Color(0xFF0F172A),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isPrimary ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
