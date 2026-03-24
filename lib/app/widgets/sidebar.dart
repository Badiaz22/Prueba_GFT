import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/l10n_extension.dart';
import 'language_switcher.dart';
import 'sidebar_item.dart';

/// Barra lateral de navegación para la versión de escritorio.
class Sidebar extends StatelessWidget {
  final int currentIndex;

  const Sidebar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 256,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.account_balance_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.footerBrandName,
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.footerInvestorLabel,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Nav items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SidebarItem(
                  icon: Icons.dashboard_rounded,
                  label: context.l10n.sidebarDashboardLabel,
                  isSelected: currentIndex == 0,
                  onTap: () => context.go('/'),
                ),
                const SizedBox(height: 4),
                SidebarItem(
                  icon: Icons.trending_up_rounded,
                  label: context.l10n.sidebarFundsLabel,
                  isSelected: currentIndex == 1,
                  onTap: () => context.go('/funds'),
                ),
                const SizedBox(height: 4),
                SidebarItem(
                  icon: Icons.receipt_long_rounded,
                  label: context.l10n.sidebarTransactionsLabel,
                  isSelected: currentIndex == 2,
                  onTap: () => context.go('/transactions'),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Language switcher
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: const LanguageSwitcher(),
          ),
        ],
      ),
    );
  }
}
