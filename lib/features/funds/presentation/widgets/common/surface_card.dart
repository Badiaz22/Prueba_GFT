import 'package:flutter/material.dart';

/// Tarjeta de superficie blanca con sombra suave y esquinas redondeadas.
class SurfaceCard extends StatelessWidget {
  /// Widget hijo que se renderiza dentro de la tarjeta.
  final Widget child;

  const SurfaceCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
