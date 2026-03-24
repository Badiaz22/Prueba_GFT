import 'app_exception.dart';

/// Se lanza cuando el monto ingresado es inferior al mínimo requerido por el fondo.
class MinimumAmountException extends AppException {
  /// Monto mínimo de inversión aceptado por el fondo.
  final int minimumAmount;

  const MinimumAmountException(this.minimumAmount)
      : super('El monto mínimo de inversión es \$$minimumAmount');
}
