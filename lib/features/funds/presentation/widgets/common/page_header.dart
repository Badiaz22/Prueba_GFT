import 'package:flutter/material.dart';

/// Encabezado de página con título principal y subtítulo descriptivo.
class PageHeader extends StatelessWidget {
  /// Título principal de la página.
  final String title;

  /// Subtítulo descriptivo que aparece bajo el título.
  final String subtitle;

  const PageHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 600;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isSmall ? 24 : 36,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
            letterSpacing: -0.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: isSmall ? 13 : 16,
            color: const Color(0xFF5E748D),
          ),
        ),
      ],
    );
  }
}
