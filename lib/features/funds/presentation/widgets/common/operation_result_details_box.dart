import 'package:flutter/material.dart';

/// Caja de detalles de una operación, con filas de etiqueta–valor.
///
/// Cada elemento de [rows] es una tupla `(etiqueta, valor, esBold)` que
/// controla el texto a mostrar y si el valor debe tener negrita.
class OperationResultDetailsBox extends StatelessWidget {
  /// Lista de filas a renderizar. Cada tupla contiene: etiqueta, valor y si va en negrita.
  final List<(String, String, bool)> rows;

  const OperationResultDetailsBox({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: rows.indexed.map((entry) {
          final index = entry.$1;
          final row = entry.$2;
          final isLast = index == rows.length - 1;
          final isMono = row.$3;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: isLast
                ? null
                : BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.$1,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    row.$2,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                      fontFamily: isMono ? 'monospace' : null,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
