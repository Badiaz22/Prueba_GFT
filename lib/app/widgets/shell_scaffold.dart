import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/responsive.dart';
import 'desktop_layout.dart';
import 'mobile_layout.dart';

/// Andamiaje principal de la aplicación con navegación adaptativa.
///
/// En pantallas anchas (> 800 px) renderiza [DesktopLayout] con barra
/// lateral; en pantallas pequeñas usa [MobileLayout] con barra inferior.
class ShellScaffold extends StatelessWidget {
  /// Widget hijo que representa el contenido de la ruta activa.
  final Widget child;

  const ShellScaffold({super.key, required this.child});

  /// Retorna el índice de navegación según la ruta actual.
  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == '/funds') return 1;
    if (location == '/transactions') return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) {
      return DesktopLayout(currentIndex: _currentIndex(context), child: child);
    }

    return MobileLayout(currentIndex: _currentIndex(context), child: child);
  }
}
