import '../entities/transaction_entity.dart';
import '../repositories/funds_repository.dart';

/// Caso de uso: obtener el historial de transacciones del usuario.
class GetTransactionsUseCase {
  final FundsRepository _repository;

  const GetTransactionsUseCase(this._repository);

  /// Retorna la lista de [TransactionEntity] ordenadas por fecha desc.
  List<TransactionEntity> call() => _repository.getTransactions();
}
