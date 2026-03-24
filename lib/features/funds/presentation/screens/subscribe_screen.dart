import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/utils/l10n_extension.dart';
import '../../../../../core/utils/responsive.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/enums/notification_method_enum.dart';
import '../widgets/subscribe/subscribe_breadcrumb.dart';
import '../widgets/subscribe/subscribe_form_column.dart';
import '../widgets/subscribe/subscribe_details_column.dart';

/// Pantalla de suscripción a un fondo de inversión.
///
/// Recibe el [fund] al que se desea suscribir y el [currentBalance]
/// del usuario para validar que el monto ingresado sea válido.
class SubscribeScreen extends StatefulWidget {
  /// Fondo al que el usuario desea suscribirse.
  final FundEntity fund;

  /// Saldo actual disponible del usuario en COP.
  final int currentBalance;

  const SubscribeScreen({
    super.key,
    required this.fund,
    required this.currentBalance,
  });

  @override
  State<SubscribeScreen> createState() => _SubscribeScreenState();
}

/// Estado interno de [SubscribeScreen] con animaciones de entrada escalonadas.
class _SubscribeScreenState extends State<SubscribeScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  NotificationMethodEnum _selectedMethod = NotificationMethodEnum.email;
  String? _inlineError;

  late AnimationController _entranceCtrl;
  late List<Animation<double>> _itemFades;
  late List<Animation<Offset>> _itemSlides;

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.fund.minimumAmount.toString();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    const count = 4;
    _itemFades = List.generate(count, (i) {
      final start = i * 0.18;
      return CurvedAnimation(
        parent: _entranceCtrl,
        curve: Interval(
          start,
          (start + 0.55).clamp(0.0, 1.0),
          curve: Curves.easeOut,
        ),
      );
    });
    _itemSlides = _itemFades
        .map(
          (fade) => Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(fade),
        )
        .toList();

    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _entranceCtrl.dispose();
    super.dispose();
  }

  /// Valida el monto ingresado y actualiza [_inlineError] en consecuencia.
  void _validate() {
    final value = _amountController.text;
    if (value.isEmpty) {
      setState(
        () => _inlineError = context.l10n.subscribeValidationEnterAmount,
      );
      return;
    }
    final amount = int.tryParse(value);
    if (amount == null || amount <= 0) {
      setState(
        () => _inlineError = context.l10n.subscribeValidationInvalidAmount,
      );
      return;
    }
    if (amount < widget.fund.minimumAmount) {
      setState(
        () => _inlineError = context.l10n.subscribeValidationBelowMinimum(
          CurrencyFormatter.format(widget.fund.minimumAmount),
        ),
      );
      return;
    }
    if (amount > widget.currentBalance) {
      setState(
        () => _inlineError = context.l10n.subscribeValidationExceedsBalance(
          CurrencyFormatter.format(widget.currentBalance),
        ),
      );
      return;
    }
    setState(() => _inlineError = null);
  }

  void _onSubmit() {
    _validate();
    if (_inlineError != null) return;
    final amount = int.parse(_amountController.text);
    Navigator.of(
      context,
    ).pop({'amount': amount, 'notificationMethod': _selectedMethod});
  }

  Widget _animated(int index, Widget child) {
    return SlideTransition(
      position: _itemSlides[index],
      child: FadeTransition(opacity: _itemFades[index], child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = context.isWide;
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
                _animated(0, const SubscribeBreadcrumb()),
                const SizedBox(height: 28),
                _animated(
                  1,
                  Builder(
                    builder: (context) {
                      final isSmall = context.isMobile;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.subscribeTitle,
                            style: TextStyle(
                              fontSize: isSmall ? 22 : 28,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            context.l10n.subscribeFundSubtitle(
                              widget.fund.name,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSubtitleColor,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: _animated(
                              2,
                              SubscribeFormColumn(
                                formKey: _formKey,
                                amountController: _amountController,
                                selectedMethod: _selectedMethod,
                                inlineError: _inlineError,
                                fund: widget.fund,
                                onMethodChanged: (m) =>
                                    setState(() => _selectedMethod = m),
                                onAmountChanged: (_) => _validate(),
                                onSubmit: _onSubmit,
                                onCancel: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          SizedBox(
                            width: 300,
                            child: _animated(
                              3,
                              SubscribeDetailsColumn(
                                fund: widget.fund,
                                currentBalance: widget.currentBalance,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _animated(
                            2,
                            SubscribeFormColumn(
                              formKey: _formKey,
                              amountController: _amountController,
                              selectedMethod: _selectedMethod,
                              inlineError: _inlineError,
                              fund: widget.fund,
                              onMethodChanged: (m) =>
                                  setState(() => _selectedMethod = m),
                              onAmountChanged: (_) => _validate(),
                              onSubmit: _onSubmit,
                              onCancel: () => Navigator.of(context).pop(),
                            ),
                          ),
                          const SizedBox(height: 24),
                          _animated(
                            3,
                            SubscribeDetailsColumn(
                              fund: widget.fund,
                              currentBalance: widget.currentBalance,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
