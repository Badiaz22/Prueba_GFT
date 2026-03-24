import 'fund_entity.dart';

/// Representa una entrada activa en el portafolio del usuario.
///
/// Vincula un [FundEntity] con el monto invertido y la fecha de suscripción.
class PortfolioEntryEntity {
  /// Fondo al que el usuario está suscrito.
  final FundEntity fund;

  /// Monto en COP que el usuario invirtió en este fondo.
  final int investedAmount;

  /// Fecha en que se realizó la suscripción.
  final DateTime subscribedDate;

  const PortfolioEntryEntity({
    required this.fund,
    required this.investedAmount,
    required this.subscribedDate,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioEntryEntity &&
          runtimeType == other.runtimeType &&
          fund == other.fund &&
          investedAmount == other.investedAmount;

  @override
  int get hashCode => Object.hash(fund, investedAmount);
}
