import 'package:flutter/material.dart';
import 'sidebar.dart';

/// Layout de escritorio: muestra la barra lateral [Sidebar] y el contenido principal.
class DesktopLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const DesktopLayout({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(currentIndex: currentIndex),
          Expanded(child: child),
        ],
      ),
    );
  }
}
