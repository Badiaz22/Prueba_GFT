import 'package:flutter/material.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Tarjeta de error que se muestra cuando la carga de fondos falla.
class FundsErrorCard extends StatelessWidget {
  /// Mensaje de error a mostrar al usuario.
  final String error;

  const FundsErrorCard({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 40, color: Colors.red.shade400),
          const SizedBox(height: 12),
          Text(
            context.l10n.fundsErrorTitle,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(error, style: TextStyle(color: Colors.red.shade600)),
        ],
      ),
    );
  }
}
