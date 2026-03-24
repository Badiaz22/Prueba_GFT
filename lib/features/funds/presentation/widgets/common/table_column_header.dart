import 'package:flutter/material.dart';

/// Encabezado de columna para tablas, con soporte de alineación y peso flexible.
class TableColumnHeader extends StatelessWidget {
  /// Texto a mostrar en el encabezado.
  final String text;

  /// Factor de expansión flexible de la columna dentro de una fila [Row].
  final int flex;

  /// Si es `true`, el texto se alinea a la derecha.
  final bool alignRight;

  /// Si es `true`, el texto se centra horizontalmente.
  final bool alignCenter;

  const TableColumnHeader(
    this.text, {
    super.key,
    this.flex = 1,
    this.alignRight = false,
    this.alignCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignCenter
            ? TextAlign.center
            : alignRight
            ? TextAlign.right
            : TextAlign.left,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF5E748D),
          letterSpacing: 1,
        ),
      ),
    );
  }
}
