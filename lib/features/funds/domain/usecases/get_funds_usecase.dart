import 'package:dartz/dartz.dart';

import '../../../../core/errors/app_exception.dart';
import '../entities/fund_entity.dart';
import '../repositories/funds_repository.dart';

/// Caso de uso: obtener el catálogo de fondos de inversión disponibles.
class GetFundsUseCase {
  final FundsRepository _repository;

  const GetFundsUseCase(this._repository);

  /// Delega al repositorio y retorna [Right(funds)] o [Left(AppException)] ante un fallo.
  Future<Either<AppException, List<FundEntity>>> call() async {
    try {
      final funds = await _repository.getFunds();
      return Right(funds);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }
}
