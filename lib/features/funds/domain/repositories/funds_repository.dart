import '../entities/fund_entity.dart';
import '../entities/transaction_entity.dart';
import '../entities/portfolio_entry_entity.dart';

/// Contrato del repositorio de fondos de inversión.
///
/// Define las operaciones disponibles para la capa de dominio,
/// desacoplando la lógica de negocio de la implementación de datos.
abstract class FundsRepository {
  /// Obtiene el catálogo completo de fondos disponibles.
  Future<List<FundEntity>> getFunds();

  /// Suscribe al usuario a [fund] con el [amount] indicado.
  Future<void> subscribeToFund({
    required FundEntity fund,
    required int amount,
    required NotificationMethodEnum notificationMethod,
  });

  /// Cancela la suscripción activa al fondo identificado por [fundId].
  Future<void> cancelFundSubscription({required int fundId});

  /// Retorna el historial completo de transacciones del usuario.
  List<TransactionEntity> getTransactions();

  /// Retorna las entradas activas del portafolio del usuario.
  List<PortfolioEntryEntity> getPortfolio();

  /// Retorna el saldo disponible actual del usuario en COP.
  int getBalance();
}
