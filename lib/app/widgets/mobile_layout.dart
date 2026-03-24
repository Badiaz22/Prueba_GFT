import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/l10n_extension.dart';
import 'bottom_nav_item.dart';
import 'language_switcher.dart';

/// Layout móvil: muestra el contenido y una barra de navegación inferior.
class MobileLayout extends StatelessWidget {
  final int currentIndex;
  final Widget child;

  const MobileLayout({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade100)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(
                  icon: Icons.home_rounded,
                  label: context.l10n.navDashboard,
                  isSelected: currentIndex == 0,
                  onTap: () => context.go('/'),
                ),
                BottomNavItem(
                  icon: Icons.account_balance_rounded,
                  label: context.l10n.navFunds,
                  isSelected: currentIndex == 1,
                  onTap: () => context.go('/funds'),
                ),
                BottomNavItem(
                  icon: Icons.receipt_long_rounded,
                  label: context.l10n.navTransactions,
                  isSelected: currentIndex == 2,
                  onTap: () => context.go('/transactions'),
                ),
                const LanguageSwitcher(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
