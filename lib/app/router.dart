import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/funds/presentation/screens/dashboard_screen.dart';
import '../features/funds/presentation/screens/funds_screen.dart';
import '../features/funds/presentation/screens/transactions_screen.dart';
import 'widgets/shell_scaffold.dart';

/// Clave global del navegador raíz de la aplicación.
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Clave global del navegador del shell compartido.
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Router principal de la aplicación usando GoRouter.
///
/// Define un [ShellRoute] que mantiene el [ShellScaffold] persistente
/// mientras se navega entre las rutas `/`, `/funds` y `/transactions`.
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DashboardScreen()),
        ),
        GoRoute(
          path: '/funds',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FundsScreen()),
        ),
        GoRoute(
          path: '/transactions',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: TransactionsScreen()),
        ),
      ],
    ),
  ],
);
