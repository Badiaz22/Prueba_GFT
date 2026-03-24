import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/fund_entity.dart';
import '../../domain/enums/notification_method_enum.dart';
import 'funds_provider.dart';
import 'portfolio_state.dart';

part 'portfolio_notifier.g.dart';

/// Notifier que gestiona el estado del portafolio del usuario.
///
/// Expone operaciones de suscripción y cancelación que retornan
/// [Either<AppException, Unit>] en lugar de lanzar excepciones.
@Riverpod(keepAlive: true)
class PortfolioNotifier extends _$PortfolioNotifier {
  @override
  PortfolioState build() {
    final repository = ref.read(fundsRepositoryNotifierProvider);
    return PortfolioState(
      balance: repository.getBalance(),
      entries: repository.getPortfolio(),
    );
  }

  /// Ejecuta la suscripción a [fund] con el [amount] indicado.
  ///
  /// Retorna [Right(unit)] si fue exitosa, o [Left(AppException)] ante cualquier
  /// error de negocio sin lanzar excepciones al caller.
  Future<Either<AppException, Unit>> subscribe({
    required FundEntity fund,
    required int amount,
    required NotificationMethodEnum notificationMethod,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(subscribeToFundUseCaseProvider);
    final result = await useCase(
      fund: fund,
      amount: amount,
      notificationMethod: notificationMethod,
    );

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure),
      (_) => _refreshState(),
    );

    return result;
  }

  /// Cancela la participación en el fondo identificado por [fundId].
  ///
  /// Retorna [Right(unit)] si fue exitosa, o [Left(AppException)] ante
  /// cualquier error de negocio sin lanzar excepciones al caller.
  Future<Either<AppException, Unit>> cancelSubscription({
    required int fundId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(cancelFundSubscriptionUseCaseProvider);
    final result = await useCase(fundId: fundId);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, error: failure),
      (_) => _refreshState(),
    );

    return result;
  }

  /// Recarga el saldo y el portafolio desde el repositorio tras una operación exitosa.
  void _refreshState() {
    final repository = ref.read(fundsRepositoryNotifierProvider);
    state = PortfolioState(
      balance: repository.getBalance(),
      entries: repository.getPortfolio(),
    );
  }
}
