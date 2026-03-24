import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_exception.dart';
import '../entities/fund_entity.dart';
import '../enums/notification_method_enum.dart';
import '../repositories/funds_repository.dart';

/// Caso de uso: suscribir al usuario a un fondo de inversión.
///
/// Aplica las siguientes validaciones de negocio antes de persistir:
/// - El usuario no puede suscribirse dos veces al mismo fondo.
/// - El monto debe ser mayor o igual al mínimo del fondo.
/// - El monto no puede superar el saldo disponible.
class SubscribeToFundUseCase {
  final FundsRepository _repository;

  const SubscribeToFundUseCase(this._repository);

  /// Ejecuta la suscripción validando las reglas de negocio.
  ///
  /// Retorna [Right(unit)] si la suscripción fue exitosa.
  /// Retorna [Left(AlreadySubscribedException)] si el fondo ya está en el portafolio.
  /// Retorna [Left(MinimumAmountException)] si [amount] es inferior al mínimo.
  /// Retorna [Left(InsufficientBalanceException)] si [amount] supera el saldo.
  Future<Either<AppException, Unit>> call({
    required FundEntity fund,
    required int amount,
    required NotificationMethodEnum notificationMethod,
  }) async {
    final balance = _repository.getBalance();
    final portfolio = _repository.getPortfolio();

    final alreadySubscribed = portfolio.any(
      (entry) => entry.fund.id == fund.id,
    );
    if (alreadySubscribed) {
      return const Left(AlreadySubscribedException());
    }

    if (amount < fund.minimumAmount) {
      return Left(MinimumAmountException(fund.minimumAmount));
    }

    if (amount > balance) {
      return const Left(InsufficientBalanceException());
    }

    await _repository.subscribeToFund(
      fund: fund,
      amount: amount,
      notificationMethod: notificationMethod,
    );
    return const Right(unit);
  }
}
