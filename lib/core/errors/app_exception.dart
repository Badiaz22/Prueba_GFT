export 'already_subscribed_exception.dart';
export 'fund_not_found_exception.dart';
export 'insufficient_balance_exception.dart';
export 'minimum_amount_exception.dart';

/// Excepción base de la capa de dominio.
///
/// Todas las excepciones de negocio deben extender esta clase
/// para facilitar su captura de forma centralizada.
class AppException implements Exception {
  /// Mensaje descriptivo del error ocurrido.
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}
