import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

/// Tarjeta seleccionable para elegir el método de notificación (email o SMS).
class NotificationMethodCard extends StatelessWidget {
  /// Ícono representativo del método de notificación.
  final IconData icon;

  /// Nombre del método de notificación.
  final String label;

  /// Descripción breve del método.
  final String description;

  /// `true` si esta tarjeta está actualmente seleccionada.
  final bool isSelected;

  /// Callback invocado cuando el usuario selecciona esta tarjeta.
  final VoidCallback onTap;

  const NotificationMethodCard({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : AppTheme.borderLightColor,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? AppTheme.primaryColor.withValues(alpha: 0.04)
              : Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppTheme.primaryColor
                          : AppTheme.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textMutedColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                size: 18,
                color: AppTheme.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
