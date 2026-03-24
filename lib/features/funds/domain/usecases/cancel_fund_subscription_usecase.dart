import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_exception.dart';
import '../repositories/funds_repository.dart';

/// Caso de uso: cancelar la suscripción activa a un fondo de inversión.
///
/// Verifica que el fondo exista en el portafolio antes de proceder.
class CancelFundSubscriptionUseCase {
  final FundsRepository _repository;

  const CancelFundSubscriptionUseCase(this._repository);

  /// Cancela la participación del usuario en el fondo con [fundId].
  ///
  /// Retorna [Right(unit)] si la cancelación fue exitosa.
  /// Retorna [Left(FundNotFoundException)] si el fondo no está en el portafolio activo.
  Future<Either<AppException, Unit>> call({required int fundId}) async {
    final portfolio = _repository.getPortfolio();
    final isSubscribed = portfolio.any((entry) => entry.fund.id == fundId);

    if (!isSubscribed) {
      return const Left(FundNotFoundException());
    }

    await _repository.cancelFundSubscription(fundId: fundId);
    return const Right(unit);
  }
}
