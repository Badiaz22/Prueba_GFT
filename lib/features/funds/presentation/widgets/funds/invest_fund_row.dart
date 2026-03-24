import 'package:btg_capital/features/funds/domain/entities/fund_entity.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../../core/utils/l10n_extension.dart';

/// Fila de un fondo disponible en el catálogo de inversiones.
class InvestFundRow extends StatefulWidget {
  /// Fondo que esta fila representa.
  final FundEntity fund;

  /// Indica si el usuario ya está suscrito a este fondo.
  final bool isSubscribed;

  /// Callback invocado cuando el usuario pulsa el botón de suscribirse.
  final VoidCallback onSubscribe;

  const InvestFundRow({
    super.key,
    required this.fund,
    required this.isSubscribed,
    required this.onSubscribe,
  });

  @override
  State<InvestFundRow> createState() => _InvestFundRowState();
}

/// Estado interno de [InvestFundRow] con animación de entrada escalonada.
class _InvestFundRowState extends State<InvestFundRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isFpv = widget.fund.category == FundCategoryEnum.fpv;
    final badgeBg = isFpv ? AppTheme.fpvBadgeBgColor : AppTheme.ficBadgeBgColor;
    final badgeColor = isFpv
        ? AppTheme.fpvBadgeFgColor
        : AppTheme.ficBadgeFgColor;
    final badgeLabel = isFpv
        ? context.l10n.fundCategoryFpv
        : context.l10n.fundCategoryFic;
    final isSmall = MediaQuery.of(context).size.width < 600;

    final fundTypeLabel = isFpv
        ? context.l10n.fundTypeFpvLabel
        : context.l10n.fundTypeFicLabel;

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        badgeLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: badgeColor,
        ),
      ),
    );

    final subscribeButton = widget.isSubscribed
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.successLightColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.l10n.fundSubscribedLabel,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppTheme.successDarkColor,
              ),
            ),
          )
        : Material(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              onTap: widget.onSubscribe,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  context.l10n.fundSubscribeButton,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fund.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              fundTypeLabel,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF5E748D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      badge,
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '${context.l10n.fundMinPrefix}${CurrencyFormatter.format(widget.fund.minimumAmount)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF334155),
                        ),
                      ),
                      const Spacer(),
                      subscribeButton,
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fund.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          fundTypeLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF5E748D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(alignment: Alignment.centerLeft, child: badge),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      CurrencyFormatter.format(widget.fund.minimumAmount),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: widget.isSubscribed
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                context.l10n.fundSubscribedLabel,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF047857),
                                ),
                              ),
                            )
                          : Text(
                              context.l10n.fundAvailableLabel,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF5E748D),
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: widget.isSubscribed
                          ? Text(
                              context.l10n.fundAlreadySubscribed,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Material(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                onTap: widget.onSubscribe,
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 8,
                                  ),
                                  child: Text(
                                    context.l10n.fundSubscribeButton,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
