import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../../../core/utils/responsive.dart';
import '../providers/funds_provider.dart';
import '../widgets/common/app_breadcrumb.dart';
import '../widgets/common/page_header.dart';
import '../widgets/common/section_tab_bar.dart';
import '../widgets/common/support_footer.dart';
import '../widgets/common/app_footer.dart';
import '../widgets/funds/funds_table.dart';
import '../widgets/funds/funds_error_card.dart';

/// Pantalla de inversiones que lista todos los fondos disponibles.
///
/// Permite al usuario explorar fondos, ver sus detalles y navegar
/// a la página de suscripción.
class FundsScreen extends ConsumerWidget {
  const FundsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fundsAsync = ref.watch(fundsProvider);
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
                AppBreadcrumb(currentPage: context.l10n.breadcrumbFunds),
                SizedBox(height: context.verticalSpacingMd),

                PageHeader(
                  title: context.l10n.fundsTitle,
                  subtitle: context.l10n.fundsSubtitle,
                ),
                SizedBox(height: context.verticalSpacingMd),

                SectionTabBar(
                  label: context.l10n.fundsTabLabel,
                  count: fundsAsync.valueOrNull?.length ?? 0,
                ),
                const SizedBox(height: 24),

                fundsAsync.when(
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(48),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, _) => FundsErrorCard(error: error.toString()),
                  data: (funds) => FundsTable(funds: funds),
                ),
                const SizedBox(height: 40),

                const SupportFooter(),
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
