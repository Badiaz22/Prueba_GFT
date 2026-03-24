import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../../../core/utils/responsive.dart';
import '../providers/transactions_provider.dart';
import '../widgets/common/app_breadcrumb.dart';
import '../widgets/common/page_header.dart';
import '../widgets/common/section_tab_bar.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/transactions/transactions_table.dart';
import '../widgets/transactions/transactions_empty_state.dart';

/// Pantalla que muestra el historial de transacciones del usuario.
///
/// Lista todas las suscripciones y cancelaciones realizadas,
/// ordenadas cronológicamente.
class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.horizontalPadding,
          vertical: 32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBreadcrumb(currentPage: context.l10n.breadcrumbTransactions),
                SizedBox(height: context.verticalSpacingMd),

                PageHeader(
                  title: context.l10n.transactionsTitle,
                  subtitle: context.l10n.transactionsSubtitle,
                ),
                SizedBox(height: context.verticalSpacingMd),

                SectionTabBar(
                  label: context.l10n.transactionsTabLabel,
                  count: transactions.length,
                ),
                const SizedBox(height: 24),

                if (transactions.isEmpty)
                  const TransactionsEmptyState()
                else
                  TransactionsTable(transactions: transactions),

                const SizedBox(height: 40),
                const AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
