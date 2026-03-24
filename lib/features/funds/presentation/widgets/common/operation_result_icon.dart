import 'package:flutter/material.dart';

/// Ícono circular que representa el resultado de una operación (éxito o error).
class OperationResultIcon extends StatelessWidget {
  /// `true` muestra un ícono de éxito; `false` muestra uno de error.
  final bool isSuccess;

  const OperationResultIcon({super.key, required this.isSuccess});

  @override
  Widget build(BuildContext context) {
    final bg = isSuccess ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2);
    final circleColor = isSuccess
        ? const Color(0xFF22C55E)
        : const Color(0xFFEF4444);
    final shadowColor = isSuccess
        ? const Color(0xFF22C55E).withValues(alpha: 0.3)
        : const Color(0xFFEF4444).withValues(alpha: 0.3);
    final icon = isSuccess ? Icons.check_rounded : Icons.close_rounded;

    return SizedBox(
      width: 72,
      height: 72,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          ),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
