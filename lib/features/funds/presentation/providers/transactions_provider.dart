import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transaction_entity.dart';
import 'funds_provider.dart';
import 'portfolio_provider.dart';

part 'transactions_provider.g.dart';

/// Provider reactivo que expone el historial de transacciones del usuario.
///
/// Escucha cambios en [portfolioNotifierProvider] para refrescarse
/// automáticamente tras cada suscripción o cancelación.
@riverpod
List<TransactionEntity> transactions(TransactionsRef ref) {
  ref.watch(portfolioNotifierProvider);
  final repository = ref.watch(fundsRepositoryNotifierProvider);
  return repository.getTransactions();
}
