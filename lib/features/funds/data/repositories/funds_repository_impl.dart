import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/entities/portfolio_entry_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/funds_repository.dart';
import '../datasources/funds_local_datasource.dart';

/// Implementación concreta de [FundsRepository].
///
/// Gestiona en memoria el portafolio, el historial de transacciones
/// y el saldo del usuario durante la sesión activa.
class FundsRepositoryImpl implements FundsRepository {
  final FundsLocalDatasource _datasource;

  /// Saldo disponible actual del usuario en COP.
  int _balance = AppConstants.initialBalance;

  /// Historial de transacciones registradas durante la sesión.
  final List<TransactionEntity> _transactions = [];

  /// Entradas activas del portafolio del usuario.
  final List<PortfolioEntryEntity> _portfolio = [];

  FundsRepositoryImpl(this._datasource);

  @override
  /// Obtiene los fondos del datasource y los convierte a entidades de dominio.
  Future<List<FundEntity>> getFunds() async {
    final models = await _datasource.getFunds();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  /// Descuenta [amount] del saldo, agrega la entrada al portafolio
  /// y registra la transacción correspondiente.
  Future<void> subscribeToFund({
    required FundEntity fund,
    required int amount,
    required NotificationMethodEnum notificationMethod,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: AppConstants.apiSimulatedDelay),
    );

    _balance -= amount;

    _portfolio.add(
      PortfolioEntryEntity(
        fund: fund,
        investedAmount: amount,
        subscribedDate: DateTime.now(),
      ),
    );

    _transactions.add(
      TransactionEntity(
        id: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
        fundId: fund.id,
        fundName: fund.name,
        amount: amount,
        type: TransactionTypeEnum.subscription,
        notificationMethod: notificationMethod,
        date: DateTime.now(),
      ),
    );
  }

  @override
  /// Devuelve el monto al saldo, elimina la entrada del portafolio
  /// y registra la transacción de cancelación.
  Future<void> cancelFundSubscription({required int fundId}) async {
    await Future.delayed(
      const Duration(milliseconds: AppConstants.apiSimulatedDelay),
    );

    final entryIndex = _portfolio.indexWhere((e) => e.fund.id == fundId);
    if (entryIndex == -1) return;

    final entry = _portfolio[entryIndex];
    _balance += entry.investedAmount;
    _portfolio.removeAt(entryIndex);

    _transactions.add(
      TransactionEntity(
        id: 'TXN-${DateTime.now().millisecondsSinceEpoch}',
        fundId: entry.fund.id,
        fundName: entry.fund.name,
        amount: entry.investedAmount,
        type: TransactionTypeEnum.cancellation,
        date: DateTime.now(),
      ),
    );
  }

  @override
  /// Retorna las transacciones en orden descendente (más reciente primero).
  List<TransactionEntity> getTransactions() =>
      List.unmodifiable(_transactions.reversed);

  @override
  /// Retorna una vista inmutable del portafolio actual.
  List<PortfolioEntryEntity> getPortfolio() => List.unmodifiable(_portfolio);

  @override
  /// Retorna el saldo disponible actual del usuario.
  int getBalance() => _balance;
}
