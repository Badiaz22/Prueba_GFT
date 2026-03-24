import 'app_exception.dart';

/// Se lanza cuando el usuario no tiene saldo suficiente para la operación.
class InsufficientBalanceException extends AppException {
  const InsufficientBalanceException()
      : super('No tiene saldo suficiente para esta operación');
}
