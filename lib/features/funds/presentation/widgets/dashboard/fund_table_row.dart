import 'package:btg_capital/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Fila de la tabla del portafolio que muestra un fondo activo con opción de cancelar.
class FundTableRow extends StatefulWidget {
  /// Fondo del portafolio que representa esta fila.
  final FundEntity fund;

  /// Monto invertido en este fondo.
  final int amount;

  /// Callback que se invoca cuando el usuario solicita cancelar la suscripción.
  final VoidCallback onCancel;

  const FundTableRow({
    super.key,
    required this.fund,
    required this.amount,
    required this.onCancel,
  });

  @override
  State<FundTableRow> createState() => _FundTableRowState();
}

/// Estado interno de [FundTableRow] con animación de entrada.
class _FundTableRowState extends State<FundTableRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isFpv = widget.fund.category == FundCategoryEnum.fpv;
    final badgeColor = isFpv
        ? AppTheme.fpvBadgeFgColor
        : AppTheme.ficBadgeFgColor;
    final badgeBg = isFpv ? AppTheme.fpvBadgeBgColor : AppTheme.ficBadgeBgColor;
    final badgeLabel = isFpv
        ? context.l10n.fundCategoryFpv
        : context.l10n.fundCategoryFic;
    final isSmall = MediaQuery.of(context).size.width < 600;

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        badgeLabel,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );

    final cancelButton = InkWell(
      onTap: widget.onCancel,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          context.l10n.fundWithdrawButton,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: _isHovered ? AppTheme.surfaceHoverColor : Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 16 : 24,
          vertical: isSmall ? 14 : 20,
        ),
        child: isSmall
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.fund.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                      ),
                      badge,
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        CurrencyFormatter.format(widget.amount),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppTheme.textMediumColor,
                        ),
                      ),
                      const Spacer(),
                      cancelButton,
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      widget.fund.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(alignment: Alignment.centerLeft, child: badge),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      CurrencyFormatter.format(widget.amount),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppTheme.textMediumColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: cancelButton,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
