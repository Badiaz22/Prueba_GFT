import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/funds_local_datasource.dart';
import '../../data/repositories/funds_repository_impl.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/repositories/funds_repository.dart';
import '../../domain/usecases/cancel_fund_subscription_usecase.dart';
import '../../domain/usecases/get_funds_usecase.dart';
import '../../domain/usecases/subscribe_to_fund_usecase.dart';

part 'funds_provider.g.dart';

/// Provider de la fuente de datos local de fondos.
@riverpod
FundsLocalDatasource fundsLocalDatasource(FundsLocalDatasourceRef ref) =>
    FundsLocalDatasource();

/// Notifier que mantiene viva la única instancia de [FundsRepositoryImpl].
///
/// [keepAlive: true] garantiza que el repositorio —y su estado en memoria
/// (saldo, portafolio, transacciones)— nunca sea descartado durante la sesión.
/// Se usa [ref.read] para la fuente de datos porque [FundsLocalDatasource]
/// es inmutable; vigilarla provocaría recreaciones en cascada.
@Riverpod(keepAlive: true)
class FundsRepositoryNotifier extends _$FundsRepositoryNotifier {
  @override
  FundsRepository build() {
    final datasource = ref.read(fundsLocalDatasourceProvider);
    return FundsRepositoryImpl(datasource);
  }
}

/// Provider del caso de uso de obtención de fondos.
@riverpod
GetFundsUseCase getFundsUseCase(GetFundsUseCaseRef ref) =>
    GetFundsUseCase(ref.watch(fundsRepositoryNotifierProvider));

/// Provider del caso de uso de suscripción a un fondo.
@riverpod
SubscribeToFundUseCase subscribeToFundUseCase(SubscribeToFundUseCaseRef ref) =>
    SubscribeToFundUseCase(ref.watch(fundsRepositoryNotifierProvider));

/// Provider del caso de uso de cancelación de suscripción.
@riverpod
CancelFundSubscriptionUseCase cancelFundSubscriptionUseCase(
  CancelFundSubscriptionUseCaseRef ref,
) => CancelFundSubscriptionUseCase(ref.watch(fundsRepositoryNotifierProvider));

/// FutureProvider que expone de forma reactiva la lista de fondos disponibles.
@riverpod
Future<List<FundEntity>> funds(FundsRef ref) async {
  final getFunds = ref.watch(getFundsUseCaseProvider);
  final result = await getFunds();
  return result.fold((failure) => throw failure, (funds) => funds);
}
